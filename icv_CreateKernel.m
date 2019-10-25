function k = icv_CreateKernel(radius, type)
    if(mod(radius, 2) ~= 1)
        error('Kernel size must be an odd number')
    end
    if(type == 'median')
        k = getMedianBlurKernel(radius);
    elseif(type == 'gaussian')
        k = getGaussianBlurKernel(radius);
    end
    
end

function k = getMedianBlurKernel(radius)
    k = ones(radius, radius);
    k = k ./ sum(sum(k));
end

% To do: To be automated.
function k = getGaussianBlurKernel(radius)
    k = [1 2 1;2 4 2;1 2 1];
end