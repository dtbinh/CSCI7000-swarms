function [ f ] = func_mccormick( x )
%   https://en.wikipedia.org/wiki/Test_functions_for_optimization

f = sin(x(1) + x(2)) + (x(1) - x(2))^2 - 1.5 * x(1) + 2.5 * x(2) + 1;

end