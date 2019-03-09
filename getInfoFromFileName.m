% This functions extract information from file name %
% Output includes animal, day, date, epoch,variable names %
% Author: Zhaonan Li %

function f = getInfoFromFileName(file_name)
    % possible examples of file names %
    % EE8_01_20180514_1Sleep_direction.mat %
    % EE15_08_20180712_4Track_trajectory.mat %
    % EE8_01_20180514_2LT.mat %
    
    f = containers.Map;
    slices = strsplit(file_name, '_');
    animal = slices(1);
    day = slices(2);
    date = slices(3);
    
    % use regular expression to match first number appears in the fourth slice %
    numbers = regexp(slices(4), '[0-9]+', 'match');
    epoch = numbers{1,1};
    
    f('animal') = animal{1,1};
    f('day') = day{1,1};
    f('date') = date{1,1};
    f('epoch') = epoch{1,1};
    
end

