function [ new_img ] = Exponential_Noise( img,a )
[H W L]=size(img);
for c = 1:L
    for i = 1:255
        pixelCount=round(a*exp(-a*i)*H*W);
        for j = 1 :pixelCount
            row=ceil(rand(1,1)*H);
            column=ceil(rand(1,1)*W);
            img(row,column)=img(row,column)+i;
        end
    end
end
new_img = zeros(size(img));
new_img=stretching(img, 1,255);
new_img=uint8(new_img);
end