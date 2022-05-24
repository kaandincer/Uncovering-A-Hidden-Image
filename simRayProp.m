%% Part 1: simRayProp 
% By: Kaan Dincer and Nick Falshaw
%
% function simRayProp(M,y_in,theta_in)
% simulates propagation of rays through an object
% 
% inputs:
% M - ray transfer matrix (2D)
% y_in - list of rays' y-coordinates to propagate
% theta_in - list of rays' angles in yz plane to propagate
%
% outputs:
% y_out - list of rays' y-coordinates at output
% theta_out - list of rays' angles in yz plane at output

function [y_out,theta_out] = simRayProp(M,y_in,theta_in)
    input = [y_in;theta_in];
    output = M*input;
    y_out = output(1,:);
    theta_out = output(2,:); 
end