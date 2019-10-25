function [result] = icv_NormaliseHist(hist, img)
    % Histogram Normalisation.
    % To normalise a histogram,
    % all we have to do is to scale the count values from 0 to 1.
    % This can be done by dividing each bin with the total number of
    % pixels of the image whom we are investigating its histogram.
    result = hist / (size(img, 1) * size(img, 2));
end