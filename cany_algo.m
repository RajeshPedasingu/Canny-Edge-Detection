

function out=cany_algo(img);
img1=img;
img1 = im2gray(img1);
figure;
imshow(img1)
%img2=imread('fig2.png');


x1 = imgaussfilt(img1,2);
figure;
imshow(x1)
title('applying gaussian filter')


% hsize=3;% size of kernal 
% h1 =[-1 -2 -1;0 0 0;1 2 1];%horizantal edge detection sobel filter
% h2=h1'; 
% a1=edge_filter(x1,h1); % horizantal edge 
% a2=edge_filter(x1,h2); % vertical edge 
% 
% k1=a1;
% k2=a2;
% 
% a11=double(a1)/255;
% a22=double(a2)/255;
% b1=sqrt(a11.^2+a22.^2)*255;
% 
% k1=a1;
% k2=a2;
% 
% 
% c1=k2./k1;
% C2=atan2(k2,k1);
% m1=C2*180/pi;
% 
% figure;
% imshow(b1)
% 
% figure;
% imshow(m1)











[Gmag, Gdir] = imgradient(x1,'sobel');
figure;
imshow(Gmag)
title('magnitude of gradients')
% Gmag=b1;
% Gdir=m1;
% figure;
% imshow(m1)


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


g1=Gmag;
[n1,n2]=size(Gdir);

% for i=1:n2
%     for j=1:n1-2
%         b1=Gdir(0+j:2+j,i);
%         b2=Gmag(0+j:2+j,i);
% 
%         if max(b1)==b1(2)
%             b2(1)=0;
%             b2(3)=0;
%             g1(0+j:2+j,i)=b2;
%         end
%     end
% end


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


figure;
imshow(g1)
title('after Suppress non-maxima pixels')

t1=27;
t2=250;
k1=thresholding_img(g1,t1,t2);
figure;
imshow(k1)
title('after double thresholding')

%edge track by hhysterisis method......

k2=hyst(k1,t2);
figure;
imshow(k2)
title('Canny edge detection algorithm')













% 
% g2=Gmag;
% [n1,n2]=size(Gdir);
% 
% for i=1:n1
%     for j=1:n2-2
%         b1=Gdir(i,0+j:2+j);
%         b2=Gmag(0+j:2+j,i);
%         if max(b1)==b1(2)
%             b2(1)=0;
%             b2(3)=0;
%             g2(i,0+j:2+j)=b2;
%         end
%     end
% end
% 
% figure;
% imshow(g2)
% 
% 
% g3=sqrt(g1.*g2);
% g4=g1+g2-g3;
% 
% figure;
% imshow(g4)


% c1 = edge(img1,'Canny');
% 
% figure;
% imshow(c1)
% title('using inbuilt function')

out =k2;

end




