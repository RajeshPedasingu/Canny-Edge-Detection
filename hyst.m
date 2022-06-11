
function out=hyst(image,t2)
img2=image;


a=img2;
h=ones(3);
[ht,wt,c]=size(a);
hsize=size(h);
d=ceil(hsize/2);

a1=a;
for i=0:ht-hsize
    for j=0:wt-hsize
        b=a([1+i:hsize+i],[1+j:hsize+j]);
        b1=b.*h;
        if sum(sum(b1(b1>=t2))) > 0
        a1(d+i,d+j)=255;
        end
    end
end

out=a1;



end


