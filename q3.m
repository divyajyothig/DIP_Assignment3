clc;
clear all;
close all;

bg = imread('3.JPG');
fg = imread('me.jpg');
bg = imresize(bg,[size(fg,1) size(fg,2)]);
%%
% Identifying the green background and taking the mean of the block in the
% three channels
%%
figure, imshow(fg)
% rect2 = getrect;
rect2 = [1.0e+03*0.8085    1.0e+03*1.0640    1.0e+03*0.2310    1.0e+03*0.2550];
S = fg(rect2(2): rect2(2)+rect2(4), rect2(1):rect2(1)+rect2(3),:);

mR = mean2(S(:,:,1));
mG = mean2(S(:,:,2));
mB = mean2(S(:,:,3));

imFR = ((mR-65)<=fg(:,:,1)) & (fg(:,:,1)<=(mR+65));
imFG = ((mG-65)<=fg(:,:,2)) & (fg(:,:,2)<=(mG+65));
imFB = ((mB-65)<=fg(:,:,3)) & (fg(:,:,3)<=(mB+65));
mask = imFR & imFG & imFB;
imFu = uint8(~mask);
imFm = uint8(mask);
Ck(:,:,1) = bg(:,:,1) .* imFm + imFu .* fg(:,:,1);
Ck(:,:,2) = bg(:,:,2) .* imFm + imFu .* fg(:,:,2);
Ck(:,:,3) = bg(:,:,3) .* imFm + imFu .* fg(:,:,3);

imshow(fg)
figure, imshow(mask)
figure, imshow(Ck)