function x =  deconv_RL(img,kernel,max_iter,lambda)
    K_T = flip(flip(kernel,2) ,1);
    x = img;
    eps = 1e-12;filter_eps =1e-6;
    for iter =1:max_iter
        denom = 1+lambda*Grad_Lap(x);
        KI = fftconv(x, kernel);
        image_KI = img./KI;
        relative_blur =  image_KI;
        t = image_KI<filter_eps;
        relative_blur(t) = 0;
        K_TI = fftconv(relative_blur,K_T);
		x = (x.*K_TI)./denom;
        x = clamp(x,-1,1);
    end
    x = clamp(x,0,1);
end

function nabla = Grad_Lap(S)
    exp_a = 0.8;
    thr_e = 0.01;
    h = [diff(S,1,2), S(:,1,:) - S(:,end,:)];
    v = [diff(S,1,1); S(1,:,:) - S(end,:,:)];
    nabla=exp_a*(sign(h).*max(abs(h),thr_e).^(exp_a-1)+sign(v).*max(abs(v),thr_e).^(exp_a-1));
end

function y = clamp(x,bl,bu)
  % return bounded value clipped between bl and bu
  y=min(max(x,bl),bu);
end


