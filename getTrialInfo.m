% This function generates numbers of trials and arm number associated with each trail
% Author: Zhaonan Li
% Input: file name of posdata
% Output: a matrix of size (n, 2). n is the length of posdata
%         column one represents the track number 1-4 or -1.
%         column two represents the trail number n, n >= 1.

function f = getTrialInfo(posfilename)

% coordinate of center %
cx = 1116;
cy = 1136;
% radius of the circle %
r = 800;
% read the position matrix %
M = load(posfilename);
M = M.pos;
M = [sum(M(:,[1 3]), 2) / 2, sum(M(:,[2 4]), 2) / 2];

% result %
res = zeros(length(M), 2);

aux = zeros(length(M), 1);
for i = 1:length(M)
    aux(i) = getTrackNumber(M(i,1), M(i,2), cx, cy, r);
end

p1 = 1;
t_idx = 1;
while p1 < length(M)
    start = p1;
    while p1 < length(M) && aux(p1) ~= -1
        p1 = p1 + 1;
    end
    while p1 < length(M) && aux(p1) == -1
        p1 = p1 + 1;
    end
    if aux(p1) == 0
        for j = start:p1
            res(j,1) = -1;
            res(j,2) = t_idx;
        end
    else
        track = aux(p1);
        while p1 < length(M) && aux(p1) ~= 0
            p1 = p1 + 1;
        end
        for j = start:p1
            res(j,1) = track;
            res(j,2) = t_idx;
        end
    end
    t_idx = t_idx + 1;
end

% i = 1;
% while i < length(M) && (res(i) ~= -1 || res(i) ~= 0)
%     i = i + 1;
% end
% track = res(i-1);
% for j = i:length(M)
%     res(j) = track;
% end

% visualize the result %
% img = imread('Track.png');
% imshow(img);
% 
% hold on 
% 
% for n = 1:length(M)
%     color = 'g';
%     if res(n) == 1
%         % yellow %
%         color = 'y';
%     elseif res(n) == 2
%         % blue %
%         color = 'b';
%     elseif res(n) == 3
%         % magenta %
%         color = 'm';
%     elseif res(n) == 4
%         color = 'k';
%     end
%     plot(M(n, 1), M(n, 2), "-o"+color);
%     % uncomment this line to show the dynamic movement%
%     pause(0.003);
% end

function f = isReturned(x, y)
if y >= 1776
    f = true;
    return;
else 
    f = false;
    return;
end
end

function f = getTrackNumber(x,y, cx, cy, r)
if y >= 1776
    f = 0;
    return;
end
if y <= cy
    dis = sqrt((x-cx)^2 + (y-cy)^2);
    if dis > r
        h = x - cx;
        ang = radtodeg(acos(h/dis));
        if (x >= cx)
            if (ang <= 45) 
                f = 1;
                return;
            else
                f = 2;
                return;
            end
        else
            if (ang <= 135)
                f = 3;
                return;
            else
                f = 4;
                return;
            end
        end
    else
        f = -1;
        return;
    end
end

f = -1;
end
f = res;
end
