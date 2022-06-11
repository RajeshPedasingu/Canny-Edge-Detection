
function out=edge_filter(image,h)
img2=image(:,:,1);


a=double(img2)/255;
[ht,wt,c]=size(a);
hsize=size(h);
d=ceil(hsize/2);

a1=a;
for i=0:ht-hsize
    for j=0:wt-hsize
        b=a([1+i:hsize+i],[1+j:hsize+j]);
        b1=b.*h;
        if b(d+i,d+j)==max(max(b))
        a1(d+i,d+j)=sum(sum(b1));
    end
end

out=a1;



end


