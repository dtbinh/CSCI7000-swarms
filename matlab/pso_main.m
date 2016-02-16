close all;
clear all;

% setup particle constants
c.f = @func_sphere;
c.lb = [-10, -10];
c.ub = [10, 10];

% initialize particles
g_best = [0, 0];
fg_best = inf;

for i=1:10
    particles(i) = particle(c);
    if particles(i).fg < fg_best
       fg_best = particles(i).fg;
       g_best = particles(i).g;
    end
end
fg_best
g_best

for i=1:10
    particles(i).update_global_best(g_best, fg_best);
end

for i=1:10
    disp([i particles(i).fp particles(i).fg]);
end


    
