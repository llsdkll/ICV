function [imgSheared, canvas_new] = icv_ImageShearY(img, angle)
    % Get image's size
    [height, width, channels] = size(img);
    
    % Calculate the new image's dimensions
    offset = ceil(width * abs(icv_TanD(angle)));
    heightNew = offset + height;
    canvas_new = zeros(heightNew, width, channels);
    canvas_new = uint8(canvas_new);
    
    % Calculate the transformation matrix and its inverse
    shearMat = [1 0;icv_TanD(angle) 1];
    shearMatInv = inv(shearMat);
    
    if(angle < 0)
        canvas_new(1:height, 1:width, :) = img;
    else
        canvas_new(offset:offset + height - 1, 1:width, :) = img;
    end
    
    imgSheared = zeros(size(canvas_new));
    imgSheared = uint8(imgSheared);
    
    midY = ceil(heightNew / 2);
    
    for i=1:size(imgSheared, 1) % y'
        for j=1:size(imgSheared, 2) % x'
            x = j;
            y = j * shearMatInv(2, 1) + i * shearMatInv(2, 2);
            
            y = round(y) + (sign(angle) * midY) - (sign(angle) * ceil((height - offset) / 2));
            
            if(x>=1 && x<=size(imgSheared, 2) && y>=1 && y<=size(imgSheared, 1))
                imgSheared(i, j, :) = canvas_new(y, x, :);
            end
         end
    end
end

