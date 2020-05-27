Lx = 6;
Nx = 2^8;
Ly = 3;
Ny = 2^7;

%%
x = linspace(-Lx,Lx,Nx);
x = x(1:(end-1));
y = linspace(-2*Ly,2*Ly,Ny);
y = y(1:(end-1));
[X,Y] = meshgrid(x,y);
%%
R = sqrt(X.^2 + Y.^2);