function [newList] = removeSame(indexList)
%function checks if given index is already in list, if not then it adds it
%   indexList - array of given indexes
%   newList - returned indexes list with duplicates removed 
if(length(indexList) > 3)
    for i = 1:1:length(indexList) - 1
        if(indexList(i) == indexList(i + 1))
            indexList(i) = 0;
        end
    end
end
count = 1;
newList = zeros(3:1);
for j = 1:1:length(indexList)
    if indexList(j) ~= 0
        newList(count) = indexList(j);
        count = count + 1;
    end
end

