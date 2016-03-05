function [ f ] = func_geartrain( x )
% Particle Swarm Optimization: Performance Tuning and Empirical Analysis

f = (1/6.931 - x(1) * x(2) / (x(3) * x(4)))^2;

end