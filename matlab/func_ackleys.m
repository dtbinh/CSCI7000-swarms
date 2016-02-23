function [ f ] = func_ackleys( x )
%   https://en.wikipedia.org/wiki/Test_functions_for_optimization
a = -0.2 * sqrt(0.5 * (x(1)^2 + x(2)^2));
b = 0.5 * (cos(2*pi*x(1)) + cos(2*pi*x(2)));
f = -20 * exp(a) - exp(b) + exp(1) + 20;

end
