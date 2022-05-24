%% function [img,x,y] = rays2img(x_in,y_in,color,width,Npixels)
% generates an image from a collection of rays
%
% inputs:
% \verb|x_in|: A $1 \times N$ vector representing the $x$ position of each ray.
% \verb|y_in|: A $1 \times N$ vector representing the $y$ position of each ray.
% \verb|color|: An $3 \times N$ matrix representing the RGB color of each ray.
% \verb|width|: A scalar that specifies the total width of the image sensor in meters.
% \verb|Npixels|: A scalar that specifies the number of pixels along one side of the image sensor.
%
% outputs:
% \verb|img|: An $\mathit{width} \times \mathit{width} \times 3$ matrix representing an image captured by an image sensor of width $\mathit{width}$ with a total number of pixels $\mathit{Npixels}^2$.
% \verb|x|: A $1 \times 2$ vector that specifies the $x$ position of the left and right edges of the imaging sensor in meters.
% \verb|y|: A $1 \times 2$ vector that specifies the $y$ position of the bottom and top edges of the imaging sensor in meters.
%
% Matthew Lew 11/27/2018
function [img,x,y] = rays2img(x_in,y_in,color,width,Npixels)
% eliminate rays that are off screen
onScreen = abs(x_in)<=width/2 & abs(y_in)<=width/2;
x_in = x_in(:,onScreen);
y_in = y_in(:,onScreen);
color = color(:,onScreen);

% separate screen into pixels, calculate coordinates of each pixel's edges
mPerPx = width/Npixels;
x_edges = ((1:Npixels+1)-(1+Npixels+1)/2)*mPerPx;
y_edges = ((1:Npixels+1)-(1+Npixels+1)/2)*mPerPx;

% convert ray positions to pixel indices
x_index = floor((x_in-x_edges(1))/mPerPx+1);
y_index = floor((y_in-y_edges(1))/mPerPx+1);

% sum rays at each pixel in the image, accumarray needs to sum RGB
% separately
% [N,Xedges,Yedges] = histcounts2(x_in(onScreen),y_in(onScreen),Npixels);
imgRed = accumarray([y_index(:) x_index(:)],color(1,:),[Npixels Npixels]);
imgBlue = accumarray([y_index(:) x_index(:)],color(2,:),[Npixels Npixels]);
imgGreen = accumarray([y_index(:) x_index(:)],color(3,:),[Npixels Npixels]);

% combine colors into a single image
img = cat(3,imgRed,imgBlue,imgGreen);

% rescale img to uint8 dynamic range
img = uint8(round(img/max(img(:)) * 255));
x = x_edges([1 end]);
y = y_edges([1 end]);

% figure;
% image(x_edges([1 end]),y_edges([1 end]),img); axis image xy;
end