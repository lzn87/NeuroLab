package Lab;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Scanner;

/**
 * Class for position linearization and skeleton mapping
 * @author Zhaonan Li
 */
public class Linearization {
	
	// position of center
	static double cx = 1116;
	static double cy = 1136;
	// radius
	static int r = 800;
	
	/**
	 * entrance of the program
	 * @param args
	 * @throws Exception if given file doesn't exist
	 */
	public static void main(String[] args) throws Exception {
		//linearize("Test_pos.csv");
		//skeletonMapping("Test_pos.csv");
	}
	
	/**
	 * map every points given by the csv file to specified track,
	 * write the result to a file named "Skeleton.txt"
	 * @param file csv file to read position
	 * @return two dimensional array, with x and y position.
	 * @throws Exception
	 */
	public static double[][] skeletonMapping(String file) throws Exception {
		
		BufferedWriter writer = new BufferedWriter(new FileWriter("Skeleton.txt"));
		writer.write("");
		
		double[][] matrix = csv2matrix(file);

		for (int i = 0; i < matrix.length; i++) {
			double x = matrix[i][0] - cx;
			double y = matrix[i][1] - cy;
			double dis = Math.sqrt(x * x + y * y);
			double ang = Math.toDegrees(Math.acos(x / dis));
			if (y > 0) ang = 360 - ang;
			
			double skeleton_ang = 0;
			
			if (ang <= 326.75 && ang > 213.75) {
				skeleton_ang = Math.PI * 1.5;
			} else if (ang <= 213.75 && ang > 135) {
				skeleton_ang = Math.PI * 0.875;
			} else if (ang <= 135 && ang > 90) {
				skeleton_ang = Math.PI * 0.625;
			} else if (ang <= 90 && ang > 45) {
				skeleton_ang = Math.PI * 0.375;
			} else {
				skeleton_ang = Math.PI * 0.125;
			}
			double curx = cx + dis * Math.cos(skeleton_ang);
			double cury = cy - dis * Math.sin(skeleton_ang);
			writer.write(curx + "," + cury + "\n");
			matrix[i][0] = curx;
			matrix[i][1] = cury;
		}
		writer.close();
		return matrix;
	}

	/**
	 * linearize position to certain trajectories
	 * @param file csv file of position
	 * @return array of linearized trajectory number
	 * @throws Exception if file doesn't exist
	 */
	public static int[] linearize(String file) throws Exception {
		double[][] matrix = csv2matrix(file);
		int[] res = new int[matrix.length];
		int i = 0;
		while (i < matrix.length - 10) {
			int start = i;
			int track = -1;
			while (i < matrix.length - 10 && track == -1) {
				i++;
				track = getTrackNumber(matrix[i][0], matrix[i][1]);
			}
			while (i < matrix.length - 10 && !isReturned(matrix[i][0], matrix[i][1])) {
				i++;
			}
			
			for (int j = start; j < i; j++) {
				res[j] = track;
			}
		}
		return res;
	}
	
	/**
	 * 
	 * @param x axis of given point
	 * @param y axis of given point
	 * @return true if the given point is near home
	 */
	public static boolean isReturned(double x, double y) {
		// y is greater than 2076 - 300 = 1776
		if (y >= 1776) return true;
		else return false;
	}
	
	/**
	 * return the index of the track if the position is near the end of that track
	 * otherwise return -1
	 * @param x x-axis of given point
	 * @param y y-axis of given point
	 * @return track number
	 */
	public static int getTrackNumber(double x, double y) {
		// center is at (1116, 1136)
		if (y <= cy) {
			double dis = (Math.sqrt(Math.pow(x-cx, 2) + Math.pow(y-cy, 2)));
			// radius for now is 800
			if (dis > r) {
				double h = x - cx;
				double ang = Math.toDegrees(Math.acos(h / dis));

				if (x >= cx) {
					if (ang <= 45) return 4;
					else return 3;
				} else {
					if (ang <= 45 ) return 1;
					else return 2;
				}
			}
		}
		return -1;
	}
	
	/**
	 * convert csv to java array
	 * @param file file name
	 * @return two dimensional array
	 * @throws Exception if file doesn't exist
	 */
	public static double[][] csv2matrix(String file) throws Exception{
		Scanner sc = new Scanner(new File("src/" + file));
		double[][] pos = new double[18437][2]; 
		int i = 0;
		while (sc.hasNextLine()) {
			String line = sc.nextLine();
			pos[i][0] = str2Double(line.split(",")[0]);
			pos[i][1] = str2Double(line.split(",")[1]);
			i += 1;
		}
		sc.close();
		return pos;
	}
	
	/**
	 * convert the format of input
	 * @param str string
	 * @return double represented by str
	 */
	public static double str2Double(String str) {
		// str should have format "1.110613424026460962e+03"
		double num = Double.parseDouble(str.split("e")[0]);
		int pow = Integer.parseInt(str.split("e")[1]);
		return Math.pow(10, pow) * num;
	}
}
