function num = char2num(x1)
num = abs(x1);
if num < 58
    num = num - 48;
else
    num = num - 55;
end