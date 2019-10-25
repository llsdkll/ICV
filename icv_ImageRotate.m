function [imagerot] = icv_ImageRotate(img, angle)
    [Rows, Cols, Channels] = size(img);
    Diag = sqrt(Rows^2 + Cols^2);
    
    RowPad = ceil(Diag - Rows) + 2;
    ColPad = ceil(Diag - Cols) + 2;
    
    imagepad = zeros(Rows + RowPad, Cols + ColPad, Channels);
    imagepad(ceil(RowPad/2):(ceil(RowPad/2)+Rows-1),ceil(ColPad/2):(ceil(ColPad/2)+Cols-1), :) = img;
    imagepad = uint8(imagepad);
    
    midx=ceil((size(imagepad,1)+1)/2);
    midy=ceil((size(imagepad,2)+1)/2);
    
    imagerot=zeros(size(imagepad));
    imagerot = uint8(imagerot);
    
    for i=1:size(imagerot,1)
        for j=1:size(imagerot,2)
            
            x= (i-midx)*icv_CosD(angle)+(j-midy)*icv_SinD(angle);
            y=-(i-midx)*icv_SinD(angle)+(j-midy)*icv_CosD(angle);
            x=round(x)+midx;
            y=round(y)+midy;
            
            if (x>=1 && y>=1 && x<=size(imagepad,2) && y<=size(imagepad,1))
                imagerot(i,j, :)=imagepad(x,y, :);
            end
            
        end
    end
end

