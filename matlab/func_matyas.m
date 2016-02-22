function [ f ] = func_matyas( x )
%   https://en.wikipedia.org/wiki/Test_functions_for_optimization

f = 0.26 * (x(1)^2 + x(2)^2) - 0.48 * x(1) * x(2);

end