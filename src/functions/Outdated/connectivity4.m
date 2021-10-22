function midNum = connectivity4(numCenter,numLeft,numUp,k)
% Judge 

if numCenter ~= numUp && numCenter ~= numLeft
    midNum = k;
elseif numCenter == numUp && numCenter ~= numLeft
    midNum = 1;
elseif numCenter == numLeft && numCenter ~= numUp
    midNum = 0;
else
    midNum = 1;
end

