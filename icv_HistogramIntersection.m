function [result] = icv_HistogramIntersection(hist1, hist2, numPixels)
    % We consider that both histograms are of equal size
    % Parameter numPixels is used to normalise the result to the range 0-1.
    % To do: Run it for every colour component.
    sigma = zeros(3, 1);
    for i=1:length(sigma)
        for j=1:size(hist1, 2)
            sigma(i) = sigma(i) + min(hist1(1, j, i), hist2(1, j, i));
        end
    end
    result = sigma./numPixels;
end