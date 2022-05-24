%% function [x_out,y_out,theta_x_out,theta_y_out,color] = img2rays(img,width,numRays,maxRayAngle)
% generates a series of rays from an image
%
% inputs:
% img: An H x W x 3 matrix representing an image to be converted into rays. The third dimension represents the colors red, green, and blue respectively.
% width: A scalar that represents the total width of the image in meters.
% numRays: A scalar that specifies how many rays to generate. A good ballpark number of rays to create realistic images is 1 million.
% maxRayAngle: A scalar that specifies the maximum ray angle theta (in radians) to be used for the fan of rays generated from each point on the object.
%
% outputs:
% x_out: An 1 x numRays vector representing the x position of each ray.
% y_out: An 1 x numRays vector representing the y position of each ray.
% theta_x_out: A 1 x numRays vector representing the theta_x propagation direction in the xz plane of each ray.
% theta_y_out: An 1 x numRays vector representing the theta_y propagation direction in the yz plane of each ray.
% color: An 3 x numRays matrix representing the RGB color of each ray.
%
% Matthew Lew 11/27/2018
% 11/25/2019 - revised all outputs to be single precision instead of double
% to save memory
function [x_out,y_out,theta_x_out,theta_y_out,color] = img2rays(img,width,numRays,maxRayAngle)
% calculate number of rays per pixel
imgMag = vecnorm(double(img),1,3);
imgColor = double(img)./imgMag;
imgRays = imgMag * numRays/sum(imgMag(:));    % assume 255 is brightest value (uint8)
totalRays = sum(round(imgRays(:)));     % see how many rays there are after rounding

% adjust number of rays to match number desired by calling function
numRaysToAdd = numRays - totalRays;
if numRaysToAdd > 0
    imgError = sortrows([(1:(size(imgRays,1)*size(imgRays,2)))', round(imgRays(:))-imgRays(:)],2);
    imgRays(imgError(1:numRaysToAdd,1)) = imgRays(imgError(1:numRaysToAdd,1))+1;
elseif numRaysToAdd < 0
    imgError = sortrows([(1:(size(imgRays,1)*size(imgRays,2)))', round(imgRays(:))-imgRays(:)],2,'descend');
    imgRays(imgError(1:-numRaysToAdd,1)) = imgRays(imgError(1:-numRaysToAdd,1))-1;
end
imgRays = round(imgRays);
totalRays = sum(imgRays(:));

% initialize arrays
% x_out = zeros(1,numRays);
% y_out = zeros(1,numRays);

% assign ray positions
x=((1:size(imgRays,2))-(1+size(imgRays,2))/2)*width/size(imgRays,2);
y=((1:size(imgRays,1))-(1+size(imgRays,1))/2)*width/size(imgRays,1);
[x,y] = meshgrid(x,y);
y = flipud(y);
x_out = single(repelem(x(:),imgRays(:))+(rand(totalRays,1)-0.5)*width/size(imgRays,2))';
y_out = single(repelem(y(:),imgRays(:))+(rand(totalRays,1)-0.5)*width/size(imgRays,1))';
color = single(repelem(reshape(imgColor,[],3),reshape(imgRays,[],1),1))';

% generate ray angles
% Lambertian cosine law
theta = asin(rand(totalRays,1)*sin(maxRayAngle));
% uniformly-random azimuthal angle
phi = 2*pi*rand(totalRays,1);

% convert to theta_x, theta_y
theta_x_out = single(asin(cos(phi).*sin(theta)))';
theta_y_out = single(asin(sin(phi).*sin(theta)))';
end