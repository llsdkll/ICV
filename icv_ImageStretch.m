function [result] = icv_ImageStretch(img)
result = (img-min(img(:)))/(max(img(:))-min(img(:)))
end