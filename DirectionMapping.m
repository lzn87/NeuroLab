% input matrix of positions %
M = csvread("Test_pos.csv");
% result matrix, 1 represents moving away from home, -1 is the opposite %
res = zeros(length(M)); 

for i = 1:length(M) - 1
    y = M(i, 2);
    nexty = M(i + 1, 2);
    if nexty > y 
        res(i) = -1;
    else
        res(i) = 1;
    end
end

% the direction of last position is by defualt 1(or -1)%
res(length(M)) = 1;