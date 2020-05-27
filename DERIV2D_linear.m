function d2z = DERIV2D_linear(x,y,z)

%% This function compute the result of the operation of the operator fun(d/dx) to y via fourier transform
% Note that N needs to be a odd length signal
Nx = length(x);
if mod(Nx,2)==0
    disp('Signal has even x-length, it needs to be odd')
    return
end
Ny = length(y);
if mod(Ny,2)==0
    disp('Signal has even y-length, it needs to be odd')
    return
end
dx = x(2)-x(1);
dy = y(2) - y(1);

%% Compute fourier transform
 ft = fftshift(fft2(z));
 skx =2*pi/dx;
 sky = 2*pi/dy;
 kx =skx*(-((Nx-1)/2):((Nx-1)/2))/Nx;
 ky =sky*(-((Ny-1)/2):((Ny-1)/2))/Ny; 
 
 [KX,KY] = meshgrid(kx,ky);
%% Spectral derivative
 dft = -(KX.^2 + KY.^2).*ft;
    
%% Result
d2z = ifft2(ifftshift(dft));
