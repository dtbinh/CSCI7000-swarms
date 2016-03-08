close all;
clear all;

x_best = [0.900433 0.52244 1.07644 1.949464 7.853698 8.836444 4.771224 1.007446 1.854541];
c.f = @func_transistors; c.lb = zeros(1,9); c.ub = 1e10 * ones(1,9);

num_particles = 1000;
num_iterations = 1000;
omega = 0.9;
phi_p = 3.0; 
phi_g = 3.0;

p = sobolset(9);
p = scramble(p,'MatousekAffineOwen');
p_inits = net(p,num_particles);

% initialize particles
g_best = zeros(1,9);
fg_best = inf;
for i=1:num_particles
    c.s = p_inits(i,:);
    particles(i) = particle(c);
    if particles(i).fg < fg_best
       fg_best = particles(i).fg;
       g_best = particles(i).g;
    end
    particles(i).update_global_best(g_best, fg_best);
end

% error plot
fg(1) = fg_best;
plot_e = semilogy([1:size(fg,2)],fg,'-k');
xlabel('Iterations');
ylabel('f(x)');
grid on;
waitforbuttonpress();

% main loop
for j = 1:num_iterations
    disp([j, fg_best]);
    for i=1:num_particles
        particles(i).update(omega, phi_p, phi_g);
        if particles(i).fg < fg_best
           fg_best = particles(i).fg;
           g_best = particles(i).g;
        end
        particles(i).update_global_best(g_best, fg_best);
    end
    fg(j+1) = fg_best;
    set(plot_e,'XData',[1:size(fg,2)],'YData',fg);
    pause(0.01);
end

[x_best' g_best']