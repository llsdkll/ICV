function [imgSheared] = icv_ImageShearX(img, angle)
    
    % Get the source image's size
    [height, width, channels] = size(img);
    
    % Calculate the transformation matrix and its inverse
    shearMat = [1 icv_TanD(angle); 0 1];
    shearMatInv = inv(shearMat);
    
    % Calculate the new canvas' dimensions
    offset = ceil(height * abs(icv_TanD(angle)));
    widthNew = offset + width;
    canvas_new = zeros(height, widthNew, channels);
    canvas_new = uint8(canvas_new);
    
    if(angle < 0)
        canvas_new(1:height, 1:width, :) = img;
    else
        canvas_new(1:height, offset:offset+width-1, :) = img;
    end
    
    imgSheared = zeros(size(canvas_new));
    imgSheared = uint8(imgSheared);
    
    midX = ceil(widthNew / 2);
    
    for i=1:size(imgSheared, 1) %y'
        for j=1:size(imgSheared, 2) % x'
            x = (j * shearMatInv(1,1)) + (i * shearMatInv(1,2));
            
            % If I don't use midX the new image is translated to the left
            % or right, depending the angle's sign and magnitude, as well
            % the pad size
            x = round(x) + (sign(angle) * midX) - sign(angle) * ceil((width - offset) / 2);
            y = i;
            
            %           Cols:x                            Rows:y
            if (x>=1 && x<=size(imgSheared, 2) && y>=1 && y<=size(imgSheared, 1))
                imgSheared(i, j, :) = canvas_new(y, x, :);
            end
        end
    end
end

