%% Case study 4: Ray tracing in optics
% *ESE 105* 
%
% *Name: Kaan Dincer and Nick Falshaw*

clear;
close all;

% load light field
load('lightField.mat');


%size = lenght(ray_x);

z1 = 0.6:0.001:0.7; 
f = 0.2; % 200 mm
z2 = 0.3;


fNum = 1.4;

M_f = [1, 0;
       -1/f, 1];

M_z2 = [1, z2;
        0, 1];

for i = 1:length(z1)
    
    M_z1 = [1, z1(i);
        0, 1];

    M_trans = M_z2*M_f*M_z1;

    % simulate rays traveling through the lense
    [rayx, ray_thetax] = simRayProp(M_trans, ray_x, ray_theta_x);
    [rayy, ray_thetay] = simRayProp(M_trans, ray_y, ray_theta_y);
    
   
    % visualize rays as an image
    [rayImg,x,y] = rays2img(rayx,rayy,ray_color,.025,300);
    rayImg = flipud(rayImg);
    rayImg = fliplr(rayImg);

    figure(i);
    image(x,y,rayImg); axis image xy;
    xlabel('x (m)'); ylabel('y (m)');
    
end

