function [ zz ] = Ideal_Filter(I,D0,index )
    [H W L]=size(I);
    filter=zeros(H,W,L);
    for j=1:H
        for k=1:W
            dist=sqrt((j-(H/2)).^2+(k-(W/2)).^2);
            if(dist<=D0)
                filter(j,k)=1;
            end
          
        end
    end
    if(index==0)
      filter=filter;
    else
        filter=1-filter;
    end
    fi=fft2(I);
    fi=fftshift(fi);
    reall=real(fi);
    imagin=imag(fi);
    nreall=filter.*reall;
    nimagin=filter.*imagin;
    NI=nreall(:,:)+i*nimagin(:,:);
    NI=fftshift(NI);
    NI=ifft2(NI);
    zz=mat2gray((abs(NI)));
    

end
