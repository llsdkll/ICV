function [hist] = icv_GetHist(img)

[nRows, nCols, nChannels] = size(img);
hist = zeros(1, 256, nChannels);
histGray = zeros(1, 256);

for ch=1:nChannels
    imgComponent = img(:, :, ch);
    
    for i=1:nRows
        for j=1:nCols
            index = imgComponent(i, j) + 1;
            hist(1, index, ch) = hist(1, index, ch) + 1;
        end
    end
    
    %imshow(imgComponent)
    imgComponent = zeros(nRows, nCols);
end

%x = 0:255;
%subplot(2, 1, 1)
%imshow(img)
%title('Original Image')

%subplot(2, 1, 2)
%plot(x, hist(1, :, 1), 'Red', x, hist(1, :, 2), 'Green', x, hist(1, :, 3), 'Blue')
%title('Histogram')
end