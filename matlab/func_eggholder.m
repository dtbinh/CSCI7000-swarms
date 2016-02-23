function [ f ] = func_eggholder( x )
%   https://en.wikipedia.org/wiki/Test_functions_for_optimization

a = sqrt(abs(x(1) / 2 + x(2) +47));
b = sqrt(abs(x(1) - x(2) - 47));

f = -(x(2) + 47) * sin(a)- x(1) * sin(b);

end