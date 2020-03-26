%fgehbe

 
I=imread('A (5).png');
imshow(I)
title('Input Image')
I1=rgb2gray(I);
figure,imshow(I1)
title('gray converted Image') % Image en 2D mais on peut pas disntinguer les obstacles et les zonnes accessibles par les pietons.
h=find(I1)<=50;
I1(h)=254;
d=find(I1~=255);
I1(d)=0;
figure;
imshow(I1)
