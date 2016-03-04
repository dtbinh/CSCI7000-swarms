classdef particle < handle
    % A particle for particle swarm optimization.
    % https://en.wikipedia.org/wiki/Particle_swarm_optimization
    
    properties
        c     % = input constants
%       c.f     = function handle for function to minimize 
%       c.lb    = lower bound for search space
%       c.ub    = upper bound for search space
        x     % = state vector
        fx    % = c.f evaluated at x
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
            obj.fx = obj.c.f(obj.x);
        end
        
        function obj = update_global_best(obj, g, fg)
           if fg < obj.fg
              obj.fg = fg;
              obj.g = g;
           end
        end

        function obj = update(obj,omega, phi_p, phi_g)
            % update position
            for i = 1:size(obj.x,2)
                rp = rand();
                rg = rand();
                obj.v(i) = omega * obj.v(i) + ...
                           phi_p * rp * (obj.p(i) - obj.x(i)) + ...
                           phi_g * rg * (obj.g(i) - obj.x(i));
                obj.x(i) = obj.x(i) + obj.v(i);
            end
            % check bounds
            for i=1:max(size(obj.x))    
                if obj.x(i) < obj.c.lb(i)
                   obj.x(i) = obj.c.lb(i); 
                end

                if obj.x(i) > obj.c.ub(i)
                    obj.x(i) = obj.c.ub(i);
                end                
            end

           % check if new p
           obj.fx = obj.c.f(obj.x);
           if obj.fx < obj.fp
              obj.p = obj.x;
              obj.fp = obj.fx;
              % check if new g
              if obj.fx < obj.fg
                 obj.g = obj.p;
                 obj.fg = obj.fp;
              end
           end
        end
        
        function obj = checkbounds(obj)

        end

    end
end












