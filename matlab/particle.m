classdef particle < handle
    % A particle for particle swarm optimization.
    % https://en.wikipedia.org/wiki/Particle_swarm_optimization
    
    properties
        c     % = input constants
%       c.f     = function handle for function to minimize 
%       c.lb    = lower bound for search space
%       c.ub    = upper bound for search space
        x     % = state vector
        v     % = velocity vector
        p     % = particle best
        fp    % = c.f evaluated at particle best 
        g     % = global best
        fg    % = c.f evaluated at global best
    end
    
    methods
        % Constructor
        function obj = particle(input_struct)
            obj.c = input_struct;
            
            % initialize particle
            obj.x = obj.c.lb + (obj.c.ub - obj.c.lb) .* rand(size(obj.c.lb));
            obj.p = obj.x;
            obj.fp = obj.c.f(obj.p);
            obj.g = obj.x;
            obj.fg = obj.c.f(obj.g);
            v_bound = abs(obj.c.ub - obj.c.lb);
            obj.v = -v_bound + 2 * v_bound .* rand(size(obj.c.lb));
        end
        
        function obj = update_global_best(obj, g, fg)
           if fg < obj.fg
              obj.fg = fg;
              obj.g = g;
           end
        end


    end
end