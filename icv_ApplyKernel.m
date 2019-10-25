function [imageFiltered] = icv_ApplyKernel(img, kernel)
[kRows, kCols, kSlices] = size(kernel);
[imRows, imCols, imSlices] = size(img);

if(kSlices ~= 1 || (kRows ~= kCols) || (mod(kRows, 2) ~= 1) || (mod(kCols, 2) ~= 1))
    error('Invalid kernel size. Use n x n kernel, with n an odd number')
end
    padX = floor(kCols / 2);
    padY = floor(kRows / 2);
    disp([padX, padY]);
    imagePadded = zeros(size(img, 1) + (2 * padY), size(img, 2) + (2 * padX), size(img, 3));
    %imagePadded = uint8(imagePadded);
    
    imagePadded(padY + 1:size(img, 1) + padY, padX + 1:size(img, 2) + padX, :) = img;
    
    % By default, I wrote the function to pad replicating the original
    % image's pixels.
    
    %% To do: Demonstrate the difference between zero-pad and border
    
    startY = padY +1;
    endY = startY + size(img, 1) - 1;
    
    startX = padX + 1;
    endX = startX + size(img, 2) - 1;
    
    imagePadded(startY:endY, padX:-1:1, :) = img(1:size(img, 1), 1:padX, :);
    imagePadded(startY:endY, padX + size(img, 2) + 1:size(imagePadded, 2), :) = img(1:size(img, 1), size(img, 2):-1:size(img, 2) - (padX - 1), :);
    
    imagePadded(padX:-1:1, startX:endX, :) = img(1:padY, 1:size(img, 2), :);
    imagePadded(padY + size(img, 1) + 1:size(imagePadded, 1), startX:endX, :) = img(size(img, 1):-1:size(img, 1) - (padY - 1), 1:size(img, 2), :);
    
    % Need to find a more elegant way to fill the corners
    imagePadded(1:padY, 1:padY, :) = img(padY:-1:1, padX:-1:1, :);
    imagePadded(imRows + 1 + padY:size(imagePadded, 1), 1:padX, :) = img(imRows:-1:imRows-padY+1, padX:-1:1, :);
    imagePadded(1:padY, padX + imCols + 1:size(imagePadded, 2), :) = img(padY:-1:1, imCols:-1:imCols - padX + 1, :);
    imagePadded(imRows + padY + 1:size(imagePadded, 1), imCols + padX +1:size(imagePadded, 2), :) = img(imRows:-1:imRows - padY + 1, imCols:-1:imCols - padX + 1, :);
   
    %imagePadded = double(imagePadded);
    imagePaddedCopy = zeros(size(imagePadded));
    % Applying the filter
    imageFiltered = zeros(size(img));
    block = zeros(kRows, kCols, imSlices);
    if(imSlices == 3)
        kernel = cat(3, kernel, kernel, kernel);    
    end
    for i = 1 + padY:padY + imRows
        for j = 1 + padX:padX + imCols
          
             block(:, :, :) = imagePadded(i-padY:i+padY, j-padX:j+padX, :);
             % This is where the mistake exists. We should not assign to
             % imagePadded. Solution: Create another copy!
             imagePaddedCopy(i, j, :) = sum(sum(kernel.*block));
        end
    end
    %imagePadded = uint8(imagePadded)
    
    %% The output image sampling.
    % To do: Input image as double [0, 1] and then do the stretch again and
    % convert to uint8 [0, 255]. FOR ALL KERNELS!
    imageFiltered = imagePaddedCopy(padY:padY + imRows, padX:padX + imCols, :);
    imageFiltered = uint8(imageFiltered);
end