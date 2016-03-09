clc;
clear all;
close all;
%%
% Converting gif image to rgb image
%%
[im cmap] = imread('octone.gif');
imbw = im2bw(im,0.19);
imbw_inv = 1 - imbw;
rgbImage = ind2rgb(im, cmap); 
figure,imshow(rgbImage)
title('Original image');
figure,imshow(imbw_inv)
title('Binary image');
%%
% Opening operation is done to remove the noise(small holes).
% Closing operation fills the gaps in the connected components.
% Take the inverted image after opening and closing.
%%
se12 = strel('disk',1);
IM4 = imopen(imbw_inv,se12); 
se13 = strel('disk',4);
IM5 = imclose(IM4,se13); 
figure, imshow(IM4)
title('Binary image after opening');
figure,imshow(IM5)
title({'Binary image after','opening and closing'});
im3_inv = 1 - IM5; 
[L n] = bwlabel(im3_inv);
%%
% L - Largest connected component.
% Subtracting the largest connected component from the inverted image 
% to get the yellow stars
%%
A = im3_inv;
Im=zeros([size(A,1) size(A,2)]);
ele=find(L==2);  
Im(ele)=1;
out = (im3_inv - Im); 

CMap = [0, 0, 0;  1, 1, 0.29];
RGB  = ind2rgb(out + 1, CMap);
figure, imshow(rgbImage)
title('Original Image')
figure,imshow(RGB)
title('Extracted yellow stars');
