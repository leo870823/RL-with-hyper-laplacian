clear;clc;close;
S=double(imread('8_f6.png'))/255.0;
gt = double(imread('8_f6_clear.png'))/255.0;
kernel=double(imread('6.png'));
kernel=kernel./sum(kernel(:));
deblur =  deconv_RL(S,kernel,20,8e-3);
deblur = Plot_PSNR(deblur,gt,kernel,"RL");
imshow(deblur);
imwrite(deblur,'result.png');