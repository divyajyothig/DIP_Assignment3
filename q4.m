clc;
clear all;
close all;
%%
% Cylindrical Projection : (x,y) ---> (x,siny)
%%
% Mercartor Projection : (x,y) ---> (x, ln(tan(π/4 + y/2)))
%%
% In inverse mapping 
% Cylindrical Projection : (x,y) ---> (x, arcsin(y))
%%
% Mercartor Projection : (x,y) ---> (x,2arctan(e^y)-0.5pi)

%%
im = imread('map.gif'); 
im = imresize(im,1/2,'bilinear');

for i = 1 : size(im,1)
    for j = 1 : size(im,2)
        x1(i) = (i-size(im,1)/2)/(size(im,1)/2);
        y1(j) = (j-size(im,2)/2)/(size(im,2)/2);
        y2(j) = (j-size(im,2)/2)/(size(im,2)/2)*pi/2; 
    end
end

[p1,q1] = meshgrid(y1,x1);

% Cylindrical Projection
x_new = p1;
y_new1 = asin(q1);
new1 = interp2(p1,q1,double(im),x_new,y_new1);
[p2,q2] = meshgrid(y2,x1);

% Mercartor Projection
y_new2 = 2*atan(exp(q2))-(0.5*pi);
new2 = interp2(p2,q2,double(im),x_new,y_new2);

figure,imshow(im,[]);
title('Original Map');
figure,imshow(new1);
title('Map after cylindrical projection');
figure,imshow(new2);
title('Map after mercartor projection');