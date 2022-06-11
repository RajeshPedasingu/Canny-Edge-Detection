%thresholding

function out=thresholding_img(image,t1,t2)
th=t1;

img1=image;
%Img_histogram(img1) ; %histogram

img1(img1<t1)=0;
img1(img1>=t2)=255;
%img1=medfilt2(img1(:,:,1),[5 5]);

out=img1;
end
%thresholding
