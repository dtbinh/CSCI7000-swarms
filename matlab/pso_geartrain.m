close all;
clear all;

% set variables & particle constants
c.f = @func_geartrain; c.lb = [12, 12, 12, 12]; c.ub = [60, 60, 60, 60]; c.int = 1;

num_particles = 2000;
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
    particles(i).update_global_best(g_best, fg_best);
    particle_positions(i,:) = [particles(i).x(1) * particles(i).x(2) particles(i).x(3) * particles(i).x(4) particles(i).fx];
end

% create plots
dx = (3600 - 144) / 500;
dy = (3600 - 144) / 500;
x = 144:dx:3600;
y = 144:dy:3600;
z = zeros(max(size(x)),max(size(y)));
for i = 1:max(size(x))
    for j = 1:max(size(y))
        z(j,i) = (1/6.931 - x(i) / y(j))^2;
    end
end
figure(1);
subplot(2,2,1);
surf(x,y,z,'EdgeColor','none'); hold on;
plot_p1 = scatter3(particle_positions(:,1),particle_positions(:,2),particle_positions(:,3),'.g');
plot_g1 = scatter3(g_best(1)*g_best(2),g_best(3)*g_best(4),fg_best,'or','filled');
scatter3(19*16,43*49,0,'om','filled');
xlabel('x_1 \cdot x_2');
ylabel('x_3 \cdot x_4');
zlabel('error');

subplot(2,2,2);
surf(x,y,z,'EdgeColor','none'); hold on;
view(0,90);
plot_p2 = scatter3(particle_positions(:,1),particle_positions(:,2),particle_positions(:,3),'.g');
plot_g2 = scatter3(g_best(1)*g_best(2),g_best(3)*g_best(4),fg_best,'or','filled');
scatter3(19*16,43*49,0,'om','filled');
xlabel('x_1 \cdot x_2');
ylabel('x_3 \cdot x_4');
zlabel('error');
% ylim([2500 3000]);
% xlim([200 500]);
caxis([0,0.001]);
colorbar();

subplot(2,2,4);
surf(x,y,z,'EdgeColor','none'); hold on;
view(0,90);
plot_p4 = scatter3(particle_positions(:,1),particle_positions(:,2),particle_positions(:,3),'.g');
plot_g4 = scatter3(g_best(1)*g_best(2),g_best(3)*g_best(4),fg_best,'or','filled');
scatter3(19*16,43*49,0,'om','filled');
xlabel('x_1 \cdot x_2');
ylabel('x_3 \cdot x_4');
zlabel('error');
ylim([600 3600]);
xlim([144 650]);
caxis([0,0.0001]);
colorbar();

% subplot(2,2,3);
% surf(x,y,z,'EdgeColor','none'); hold on;
% view(0,0);
% plot_p3 = scatter3(particle_positions(:,1),particle_positions(:,2),particle_positions(:,3),'.g');
% plot_g3 = scatter3(g_best(1)*g_best(2),g_best(3)*g_best(4),fg_best,'or','filled');
% scatter3(20*13,53*54,0,'om','filled');
% xlabel('x(1) * x(2)');
% ylabel('x(3) * x(4)');
% zlabel('z-axis');

% subplot(2,2,4);
% surf(x,y,z,'EdgeColor','none'); hold on;
% view(90,0);
% plot_p4 = scatter3(particle_positions(:,1),particle_positions(:,2),particle_positions(:,3),'.g');
% plot_g4 = scatter3(g_best(1)*g_best(2),g_best(3)*g_best(4),fg_best,'or','filled');
% scatter3(20*13,53*54,0,'om','filled');
% xlabel('x(1) * x(2)');
% ylabel('x(3) * x(4)');
% zlabel('z-axis');
waitforbuttonpress();

% main loop
nframe=50;
mov(1:nframe)=struct('cdata',[],'colormap',[]);
set(gca, 'nextplot', 'replacechildren');
for j = 1:50
    mov(j)=getframe(gcf);
    disp([j vpa(fg_best) g_best]);
    for i=1:num_particles
        particles(i).update(omega, phi_p, phi_g);
        if particles(i).fg < fg_best
           fg_best = particles(i).fg;
           g_best = particles(i).g;
        end
        particles(i).update_global_best(g_best, fg_best);
        particle_positions(i,:) = [particles(i).x(1) * particles(i).x(2) particles(i).x(3) * particles(i).x(4) particles(i).fx];

    end 
        set(plot_p1,'XData',particle_positions(:,1),'YData',particle_positions(:,2),'ZData',particle_positions(:,3));
    set(plot_g1,'XData',g_best(1)*g_best(2),'YData',g_best(3)*g_best(4),'ZData',fg_best);
    set(plot_p2,'XData',particle_positions(:,1),'YData',particle_positions(:,2),'ZData',particle_positions(:,3));
    set(plot_g2,'XData',g_best(1)*g_best(2),'YData',g_best(3)*g_best(4),'ZData',fg_best);
%     set(plot_p3,'XData',particle_positions(:,1),'YData',particle_positions(:,2),'ZData',particle_positions(:,3));
%     set(plot_g3,'XData',g_best(1)*g_best(2),'YData',g_best(3)*g_best(4),'ZData',fg_best);
    set(plot_p4,'XData',particle_positions(:,1),'YData',particle_positions(:,2),'ZData',particle_positions(:,3));
    set(plot_g4,'XData',g_best(1)*g_best(2),'YData',g_best(3)*g_best(4),'ZData',fg_best);    
end
movie2avi(mov,'gears.avi','fps',10,'compression','None');
