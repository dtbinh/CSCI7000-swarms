close all;
clear all;

x_best = [0.900433 0.52244 1.07644 1.949464 7.853698 8.836444 4.771224 1.007446 1.854541];
c.f = @func_transistors; c.lb = 0.001 * ones(1,9); c.ub = 1e2 * ones(1,9);

num_particles = 150;
num_iterations = 10000;
omega = 0.73;
phi_p = 1.15; 
phi_g = 1.15;

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
plot_e = loglog([1:size(fg,2)],fg,'-k');
xlabel('Iterations');
ylabel('f(x)');
grid on;
waitforbuttonpress();

% main loop
idx = 1001
for j = 1:num_iterations
    disp([j, fg_best, g_best]);
    for i=1:num_particles
        if rand() < 0.25
            c.s = p(idx,:);
            particles(i).rndRestart();
            idx = idx + 1;
        end
        particles(i).update(omega, phi_p, phi_g);
        if particles(i).fg < fg_best
           fg_best = particles(i).fg;
           g_best = particles(i).g;
        end
        particles(i).update_global_best(g_best, fg_best);
    end
    fg(j+1) = fg_best;
    set(plot_e,'XData',[1:size(fg,2)],'YData',fg);
    pause(0.001);
end

[x_best' g_best']