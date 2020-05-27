function y = get_signal2D(s)
%%
ft = fftshift(fft2(s));
[s1,s2] = size(s);
ft(1:((s1-1)/2),:)=0;
%ft(:,1:((s2-1)/2))=0;
ft((s1+1)/2,:)= ft((s1+1)/2,:)/2;
%ft(:,(s2+1)/2) = ft(:,(s2+1)/2)/2;
%ft((s1+1)/2,(s2+1)/2) =ft((s1+1)/2,(s2+1)/2)*2 ;
y = ifft2(ifftshift(ft));