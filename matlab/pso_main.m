close all;
clear all;

% set variables & particle constants
%c.f = @func_sphere; c.lb = [-5, -5]; c.ub = [5, 5];
%c.f = @func_mccormick; c.lb = [-5, -5]; c.ub = [5, 5];
%c.f = @func_matyas; c.lb = [-5, -5]; c.ub = [5, 5];
%c.f = @func_goldsteinprice; c.lb = [-5, -5]; c.ub = [5, 5];
%c.f = @func_ackleys; c.lb = [-5, -5]; c.ub = [5, 5];
c.f = @func_eggholder; c.lb = [-500, -500]; c.ub = [500, 500];

num_particles = 100;
omega = 0.73;
phi_p = 1.15; 
phi_g = 1.15;

% initialize particles
g_best = [0, 0];
fg_best = inf;
particle_positions = zeros(num_particles,3);
for i=1:num_particles
    particles(i) = particle(c);
    if particles(i).fg < fg_best
       fg_best = particles(i).fg;
       g_best = particles(i).g;
    end
end

% get initial points of particles
for i=1:num_particles
    particles(i).update_global_best(g_best, fg_best);
    particle_positions(i,:) = [particles(i).x particles(i).fx];
end

% create plots
dx = (c.ub(1) - c.lb(1)) / 200;
dy = (c.ub(2) - c.lb(2)) / 200;
x = c.lb(1):dx:c.ub(1);
y = c.lb(2):dy:c.ub(2);
z = zeros(max(size(x)),max(size(y)));
for i = 1:max(size(x))
    for j = 1:max(size(y))
        z(j,i) = c.f([x(i),y(j)]);
    end
end
figure(1);
subplot(2,2,1);
surf(x,y,z,'EdgeColor','none'); hold on;
plot_p1 = scatter3(particle_positions(:,1),particle_positions(:,2),particle_positions(:,3),'.g');
plot_g1 = scatter3(g_best(1),g_best(2),fg_best,'og');

subplot(2,2,2);
surf(x,y,z,'EdgeColor','none'); hold on;
view(0,90);
plot_p2 = scatter3(particle_positions(:,1),particle_positions(:,2),particle_positions(:,3),'.g');
plot_g2 = scatter3(g_best(1),g_best(2),fg_best,'og');

subplot(2,2,3);
surf(x,y,z,'EdgeColor','none'); hold on;
view(0,0);
plot_p3 = scatter3(particle_positions(:,1),particle_positions(:,2),particle_positions(:,3),'.g');
plot_g3 = scatter3(g_best(1),g_best(2),fg_best,'og');

subplot(2,2,4);
surf(x,y,z,'EdgeColor','none'); hold on;
view(90,0);
plot_p4 = scatter3(particle_positions(:,1),particle_positions(:,2),particle_positions(:,3),'.g');
plot_g4 = scatter3(g_best(1),g_best(2),fg_best,'og');


% main loop
for j = 1:50
    for i=1:num_particles
        particles(i).update(omega, phi_p, phi_g);
        if particles(i).fg < fg_best
           fg_best = particles(i).fg;
           g_best = particles(i).g;
        end
        particles(i).update_global_best(g_best, fg_best);
        particle_positions(i,:) = [particles(i).x particles(i).fx];
    end
    pause(0.25)
    set(plot_p1,'XData',particle_positions(:,1),'YData',particle_positions(:,2),'ZData',particle_positions(:,3));
    set(plot_g1,'XData',g_best(1),'YData',g_best(2),'ZData',fg_best);
    set(plot_p2,'XData',particle_positions(:,1),'YData',particle_positions(:,2),'ZData',particle_positions(:,3));
    set(plot_g2,'XData',g_best(1),'YData',g_best(2),'ZData',fg_best);
    set(plot_p3,'XData',particle_positions(:,1),'YData',particle_positions(:,2),'ZData',particle_positions(:,3));
    set(plot_g3,'XData',g_best(1),'YData',g_best(2),'ZData',fg_best);
    set(plot_p4,'XData',particle_positions(:,1),'YData',particle_positions(:,2),'ZData',particle_positions(:,3));
    set(plot_g4,'XData',g_best(1),'YData',g_best(2),'ZData',fg_best);    
end