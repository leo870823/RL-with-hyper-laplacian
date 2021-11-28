function [img] = Plot_PSNR(img,img_gt,kernel,tag)
    peaksnr = psnr(img,img_gt);
    
    % plot image
    img = insertText(img, [size(kernel,1)+5 0 ], sprintf('PSNR:%f %s',peaksnr,tag), 'FontSize',18,'BoxOpacity',0.0,'TextColor',[0, 255 ,255]);
    kernel_scale = kernel/max(kernel(:)) ;
    [H,W]=size(kernel_scale);
    for i=1:3
        img(1:H,1:W,i) = kernel_scale;
    end
end