clc;
clear all;
close all;

im = imread('circles.jpg');
imbw = im2bw(im,0.15);
I = imfill(imbw,'holes');
figure, imshow(im)
title('Original image')
figure, imshow(I)
title('Binary image')

se1 = strel('disk',2);
I2 = imerode(I,se1); 
se2 = strel('disk',2);
im3 = imdilate(I2,se2);
figure,imshow(I2)
title('Binary image after erosion');
figure, imshow(im3)
title({'Binary image after','erosion and dilation'})

x = im3;
c2 = 0;
for i = 3 : 20
    c2 = c2 + 1;
    se1 = strel('disk',2);
    se = strel('disk',i);
    tf = imtophat(x,se);
    tf = imopen(tf,se1);
    figure, imshow(tf)
    x = x - tf;
    [L n] = bwlabel(tf);
    c(i) = n;
    s = sum(sum(x));
    if s == 0
        break;
    end
end

display('Number of circle categories based on size')
count1 = c2
display('number of members in each category')
count2 = nonzeros(c)'
