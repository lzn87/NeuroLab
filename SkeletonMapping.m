% coordinate of center %
cx = 1116;
cy = 1136;
% read the position matrix %
M = csvread("Test_pos.csv");
% result %
res = zeros(length(M), 2);

for i = 1:length(M)
    x = M(i,1) - cx;
    y = M(i,2) - cy;
    % distance between current position and center %
    dis = sqrt(x*x + y*y);
    % angle formed between x-axis, center, and position%
    ang = radtodeg(acos(x / dis));
    % we want to map the angle in range of 0-360 %
    if (y > 0) 
        ang = 360 - ang;
    end
    if ang <= 326.75 && ang > 213.75
        ang = pi * 1.5;
    elseif ang <= 213.75 && ang > 135
        ang = pi * 0.875;
    elseif ang <= 135 && ang > 90
        ang = pi * 0.625;
    elseif ang <= 90 && ang > 45
        ang = pi * 0.375;
    else 
        ang = pi * 0.125;
    end
    
    res(i, 1) = cx + dis * cos(ang);
    res(i, 2) = cy - dis * sin(ang);
end

% draw the result %
img = imread('Track.png');
imshow(img);
hold on 

for n = 1:18000
    color = 'g';
    plot(res(n, 1), res(n, 2), "-o" + color);
    plot(M(n, 1), M(n, 2));
end