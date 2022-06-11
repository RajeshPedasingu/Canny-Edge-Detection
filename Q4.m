clc;
clear all;
close all;

img1=imread('fig5.png');

cany_algo2(img1);

img2=imread('fig6.png');

cany_algo2(img2);












function out=cany_algo2(img);
img1=img;
img1 = im2gray(img1);
figure;
imshow(img1)
title('given image')



x1 = imgaussfilt(img1,2);
% figure;
% imshow(x1)
% title('applying gaussian filter')


[Gmag, Gdir] = imgradient(x1,'sobel');





% figure;
% imshow(Gmag)
% title('magnitude of gradients')
% 

%angle bins


Gdir(Gdir <22.5 & Gdir >= -22.5 )=0;
Gdir(Gdir <67.5 & Gdir >= 22.5 )=45;
Gdir(Gdir <112.5 & Gdir >= 67.5 )=90;
Gdir(Gdir <157.5 & Gdir >= 112.5 )=135;
% Gdir(Gdir <=-157.5 & Gdir >= 157.5 )=180;
Gdir(Gdir <=180 & Gdir >= 157.5 )=180;
Gdir(Gdir <-157.5 & Gdir >= -180 )=180;
Gdir(Gdir <-112.5 & Gdir >= -157.5 )=225;
Gdir(Gdir <-67.5 & Gdir >= -112.5 )=270;
Gdir(Gdir <-22.5 & Gdir >= -67.5 )=315;



m1=Gdir;
m2=(m1==45 | m1==135 | m1==225 | m1 ==315);

Gmag=m2.*Gmag;



g1=Gmag;
[n1,n2]=size(Gdir);



for i=2:n1-1
    for j=2:n2-1
        b1=Gdir(i,j);
        if b1==0 | b1==180
            c1=Gmag(i,j-1);
            c2=Gmag(i,j);
            c3=Gmag(i,j+1);
            c=[c1 c2 c3];

            if max(c)==c2
                g1(i,j-1)=0;
                g1(i,j)=c2;
                g1(i,j+1)=0;
            end
        
        
        elseif b1==45 | b1==225
            c1=Gmag(i-1,j+1);
            c2=Gmag(i,j);
            c3=Gmag(i+1,j-1);
            c=[c1 c2 c3];

            if max(c)==c2
                g1(i-1,j+1)=0;
                g1(i,j)=c2;
                g1(i+1,j-1)=0;
            end

        elseif b1==135 | b1==315
            c1=Gmag(i-1,j-1);
            c2=Gmag(i,j);
            c3=Gmag(i+1,j+1);
            c=[c1 c2 c3];

            if max(c)==c2
                g1(i-1,j-1)=0;
                g1(i,j)=c2;
                g1(i+1,j+1)=0;
            end

        elseif b1==90 | b1==270
            c1=Gmag(i-1,j);
            c2=Gmag(i,j);
            c3=Gmag(i+1,j);
            c=[c1 c2 c3];

            if max(c)==c2
                g1(i-1,j)=0;
                g1(i,j)=c2;
                g1(i+1,j)=0;
            end

    end
    
    end
end


% figure;
% imshow(g1)
% title('after Suppress non-maxima pixels')

t1=27;
t2=250;
k1=thresholding_img(g1,t1,t2);
% figure;
% imshow(k1)
% title('after double thresholding')

%edge track by hhysterisis method......

k2=hyst(k1,t2);
figure;
imshow(k2)
title('diagonal edges using Canny algorithm')











% 
% c1 = edge(img1,'Canny');
% 
% subplot(2,2,4)
% imshow(c1)
% title('using inbuilt function')

out =k2;

end





