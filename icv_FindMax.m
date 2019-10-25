function [maxElement] = icv_FindMax(arr2D)
    rows = size(arr2D);
    cols = size(arr2D);
    
    maxElement = 0;
    for iRow = 1:rows
        for iCol = 1:cols
            if arr2D(iRow, iCol) > maxElement
                maxElement = arr2D(iRow, iCol);
            end
        end
    end
end