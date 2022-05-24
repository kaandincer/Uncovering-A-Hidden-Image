%% Part 2: A Simple Imaging System
% 
% By: Kaan Dincer and Nick Falshaw
%
%% Part 2: 1.) z1 = 250mm


z1 = 0.250; % 250 mm
f = 0.100; % 100 mm

M_z1 = [1, z1;
        0, 1];
    
M_f = [1, 0;
       -1/f, 1];
   
A = M_f*M_z1;

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
line([-z1-.01, z1], [0,0], 'LineWidth', 1, 'Color', 'k');

%plot vertical lines
line([-z1, -z1], [0, y1(1)]);
line([z2, z2], [0, y3(1)]);

ylabel('y (mm)');
xlabel('z (m)');
title('Ray Diagram 1');
%% Part 2: 2.) z1 = 45mm
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
%% Part 2: 3.) z1 from 1mm to 1m plotting z2 vs z1

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
xlabel('z1 (m)');
ylabel('z2 (m)'); 
title('z2 vs z1 With Theoretical Curve');
%% Part 2: 4.) z1 from 1mm to 1m plotting m vs z1
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
xlabel('z1 (m)');
ylabel('Magnification'); 
title('m vs z1 With Theoretical Curve');
