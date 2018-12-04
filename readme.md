# Neuroscience Lab

This is the repository I created for all the works I've done in Jadhav Lab

## Linearization.java

This is the Java program I wrote for linearizing positions of subjects and mapping each position in 4 different skeletons.
To run the program, type the method name accordingly inside the main method:

```
linearize("Test_pos.csv");
```

This will run the linearize method, where the parameter corresponds to the file name. This method takes the position information stored in the CSV file and generates a track-number corresponding to every position.

```
skeletonMapping("Test_pos.csv");
```

This will run the skeletonMapping method, where the parameter corresponds to the file name. This method takes the position information stored in the CSV file, maps each position into the nearest skeleton and writes out the output in a file named "Skeleton.txt."


## Author

* **Zhaonan Li** - (https://github.com/LIZHAONAN)

