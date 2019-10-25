function icv_Subplot(img1,img2, imTitle)
subplot(2, 1, 1)
imshow(img1)
title('Original')
subplot(2, 1, 2)
imshow(img2)
title(imTitle)
end