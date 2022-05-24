%% Part 2: z1 = 250mm


z1 = 0.250; % 250 mm
f = 0.100; % 100 mm

M_z1 = [1, z1;
        0, 1];
    
M_f = [1, 0;
       -1/f, 1];
   
A = M_f*M_z1;

% z1 - z1*z2/f + z2=0
z2 = -(z1/(A(2,2)));

M_z2 = [1, z2;
        0, 1];

M_trans = M_z2*M_f*M_z1;


% simulate rays traveling through the lense
y_in = [.001, .001, .001];
theta_in = [0, -.001/z1, -.001/(z1-f)];

[y1, theta1] = simRayProp(M_z1, y_in, theta_in);
[y2, theta2] = simRayProp(M_f, y1, theta1);
[y3, ~] = simRayProp(M_z2, y2, theta2);

figure();
hold on;
%plot object point
plot(-z1, .001, '*r');
text(-z1, .0011, 'Object P_1');

%plot blue line
line([-z1,0], [y_in(1),y1(1)], 'Color', 'b');
line([0, z2], [y2(1), y3(1)], 'Color', 'b');

%plot red line
line([-z1,0], [y_in(2),y1(2)], 'Color', 'r');
line([0, z2], [y2(2), y3(2)], 'Color', 'r');

%plot yellow line
line([-z1,0], [y_in(3),y1(3)], 'Color', 'm');
line([0, z2], [y2(3), y3(3)], 'Color', 'm');

%plot image point
plot(z2, y3(1), '*r');
text(z2, y3(1)- .0001,'Image P_2');

%plot lens
rectangle('Position', [-2e-3, y3(3)-.0005, 4e-3, 2.5*y1(1)], 'Curvature', [0.9, 0.9]);

%plot focal points
plot(f,0, '*r');
text(f, .0001, 'F');
plot(-f, 0, '*r');
text(-f, .0001, 'F');

%plot horizontal line (optical axis)
line([-z1, z2], [0,0], 'LineWidth', 1, 'Color', 'k');

%plot vertical lines
line([-z1, -z1], [0, y1(1)]);
line([z2, z2], [0, y3(1)]);

ylabel('y (mm)');
xlabel('z (m)');
title('Ray Diagram 1');
%% Part 2: z1 = 45mm
z1 = 0.045; % 45 mm
f = 0.100; % 100 mm

M_z1 = [1, z1;
        0, 1];
    
M_f = [1, 0;
       -1/f, 1];
   
A = M_f*M_z1;

z2 = -(z1/(A(2,2)));

M_z2 = [1, z2;
        0, 1];
    
% simulate rays traveling through the lense
y_in = [.001, .001, .001];
theta_in = [0, -.001/z1, -.001/(z1-f)];

[y1, theta1] = simRayProp(M_z1, y_in, theta_in);
[y2, theta2] = simRayProp(M_f, y1, theta1);
[y3, theta3] = simRayProp(M_z2, y2, theta2);

figure();
hold on;
%plot object point
plot(-z1, .001, '*r');
text(-z1, .0011, 'Object P_1');

%plot blue line
line([-z1,0], [y_in(1),y1(1)], 'Color', 'b');
line([0, z2], [y2(1), y3(1)], 'Color', 'b');

%plot red line
line([-z1,0], [y_in(2),y1(2)], 'Color', 'r');
line([0, z2], [y2(2), y3(2)], 'Color', 'r');

%plot yellow line
line([-z1,0], [y_in(3),y1(3)], 'Color', 'm');
line([0, z2], [y2(3), y3(3)], 'Color', 'm');

%plot image point
plot(z2, y3(1), '*r');
text(z2, y3(1)- .0001,'Image P_2');

%plot lens
rectangle('Position', [-2e-3, y3(3)-.0023, 4e-3, 2.5*y1(1)], 'Curvature', [0.9, 0.9]);

%plot focal points
plot(f,0, '*r');
text(f, .0001, 'F');
plot(-f, 0, '*r');
text(-f, .0001, 'F');

%plot horizontal line (optical axis)
line([-f-.01, f+.01], [0,0], 'LineWidth', 1, 'Color', 'k');

%plot vertical lines
line([-z1, -z1], [0, y1(1)]);
line([z2, z2], [0, y3(1)]);

ylabel('y (mm)');
xlabel('z (m)');
title('Ray Diagram 2');
%% z1 from 1mm to 1m plotting z2 vs z1

%z1 over a range
z1_range = 0.001:0.001:1;
z1_range = z1_range';
z2_range = zeros([length(z1_range), 1]);

for i = 1:1000
    
    z1 = 0.001*i;
    
    M_z1 = [1, z1;
    0, 1];
    
    M_f = [1, 0;
       -1/f, 1];
   
    A = M_f*M_z1;

    z2_range(i) = -(z1/(A(2,2)));
end 

% plot discrete points
figure();
plot(z1_range,z2_range,'*r');
hold on;

%theoreticl curve
f = .100;
f_vec = f*ones([length(z1_range), 1]);
z2_range = ((f_vec).^-1 - (z1_range).^-1).^-1;

% add theoretical curve to the plot
plot(z1_range,z2_range);
%% z1 from 1mm to 1m plotting m vs z1
z1_range = 0.001:0.001:1;
z1_range = z1_range';
y_in = .001;
theta_in = 0;
m = zeros([length(z1_range), 1]);

for i = 1:1000
    
    z1 = 0.001 * i;
    
    M_z1 = [1, z1;
            0, 1];
    
    M_f = [1, 0;
        -1/f, 1];
   
    A = M_f*M_z1;

    z2 = -(z1/(A(2,2)));

    M_z2 = [1, z2;
            0, 1];

    M_trans = M_z2*M_f*M_z1;
     
    [y_out, theta_out] = simRayProp(M_trans, y_in, theta_in); 
    
    m(i) = y_out/y_in;
end 

figure();
hold on;
%discrete plot
plot(z1_range, m, '*g');

%theoretical curve
f = .100;
% f_vec = f*ones([length(z1_range), 1]);
m = (1 - (z1_range)./(f)).^-1;

%add theoretical plot to curve
plot(z1_range, m);

%% Part 3:Radius of Circle of Confusion vs f-Number

f = 0.2;
z1_obj = 4;
z1_lens = 2;
y_in = 0;

fNum = 1.4:.02061:22;

radius = zeros([length(fNum), 1]);
radius = radius';

for i = 1:length(fNum)
    
    M_z1 = [1, z1_obj;
            0, 1];
    
    M_f = [1, 0;
        -1/f, 1];
   
    A = M_f*M_z1;

    z2 = -(z1_lens/(A(2,2)));

    M_z2 = [1, z2;
            0, 1];
    
    y_height = f / (2*fNum(i));
    theta_in = y_height/z1_obj;

    M_trans = M_z2*M_f*M_z1;
     
    [y_out, theta_out] = simRayProp(M_trans, y_in, theta_in); 
    
    radius(i) = y_out;
end 


figure();
plot(fNum, radius);
xlabel('f Number');
ylabel('Radius of Circle of Confusion');
title('Radius of Circle of Confusion vs f-Number');

%% Part 3: Image to rays for Turkey
z1 = 2; % 2m
f = 0.2; % 200 mm
fNum1 = 22;



M_z1 = [1, z1;
        0, 1];
    
M_f = [1, 0;
       -1/f, 1];
   
A = M_f*M_z1;

z2 = -(z1/(A(2,2)));

M_z2 = [1, z2;
        0, 1];

M_trans1 = M_z2*M_f*M_z1;

turkey = imread('200px-Turkey.png');

w = 0.2; %width
y1 = f/(2*fNum1);
maxAngle = y1/z1;
numRays = 1000000;

[x_out1, y_out1, theta_x_out1, theta_y_out1, color1] = img2rays(turkey,w, numRays ,maxAngle);

% simulate rays traveling through the lense
[x_out1, theta_x_out1] = simRayProp(M_trans1, x_out1, theta_x_out1);
[y_out1, theta_y_out1] = simRayProp(M_trans1, y_out1, theta_y_out1);

% Same process with different f-Number:
fNum2 = 1.4;
y2 = f/(2*fNum2);
maxAngle = y2/z1;

[x_out2, y_out2, theta_x_out2, theta_y_out2, color2] = img2rays(turkey,w,numRays,maxAngle);

% simulate rays traveling through the lense
[x_out2, theta_x_out2] = simRayProp(M_trans1, x_out2, theta_x_out2);
[y_out2, theta_y_out2] = simRayProp(M_trans1, y_out2, theta_y_out2);



%% Part 3: Images to rays for Snow Globe
z1 = 4; % 4m
f = 0.2; % 200 mm
fNum2 = 1.4;


M_z1 = [1, z1;
        0, 1];
    
M_f = [1, 0;
       -1/f, 1];
   
A = M_f*M_z1;

%z2 = -(z1/(A(2,2)));

M_z2 = [1, z2;
        0, 1];

M_trans2 = M_z2*M_f*M_z1;

snowGlobe = imread('200px-Snow_Globe.png');
w = 0.2; %width
y1 = f/(2*fNum2);
maxAngle = y1/z1;
numRays = 1000000;

[x_out3, y_out3, theta_x_out3, theta_y_out3, color3] = img2rays(snowGlobe,w, numRays ,maxAngle);

% simulate rays traveling through the lense
[x_out3, theta_x_out3] = simRayProp(M_trans2, x_out3, theta_x_out3);
[y_out3, theta_y_ou31] = simRayProp(M_trans2, y_out3, theta_y_out3);

% Same process with different f-Number:
fNum2 = 1.4;
y2 = f/(2*fNum1);
maxAngle = y2/z1;

[x_out4, y_out4, theta_x_out4, theta_y_out4, color4] = img2rays(snowGlobe,w,numRays,maxAngle);

% simulate rays traveling through the lense
[x_out4, theta_x_out4] = simRayProp(M_trans2, x_out4, theta_x_out4);
[y_out4, theta_y_out4] = simRayProp(M_trans2, y_out4, theta_y_out4);


%% Part 3: Rays to Image  
rays1_xconcat1 = cat(2,x_out1, x_out3);
rays1_yconcat1 = cat(2,y_out1, y_out3);
rays1_colorConcat1 = cat(2,color1, color3);

rays2_xconcat2 = cat(2,x_out2, x_out4);
rays2_yconcat2 = cat(2,y_out2, y_out4);
rays2_colorConcat2 = cat(2,color2, color4);

Npixels = 500;
sensorWidth = 0.025;

[newimg1, x_1, y_1] = rays2img(rays1_xconcat1, rays1_yconcat1, rays1_colorConcat1,sensorWidth,Npixels);

newimg1 = fliplr(newimg1);

[newimg2, x_2, y_2] = rays2img(rays2_xconcat2, rays2_yconcat2, rays2_colorConcat2,sensorWidth,Npixels);

newimg2 = fliplr(newimg2);

figure()
subplot(1,2,1);
imagesc([x_2(1);x_2(2)],[y_2(1);y_2(2)],newimg2);
axis image;

subplot(1,2,2);
imagesc([x_1(1);x_1(2)],[y_1(1);y_1(2)],newimg1);
axis image;



