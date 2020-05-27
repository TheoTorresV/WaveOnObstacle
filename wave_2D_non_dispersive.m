clear all
close all

%% Initialize x,y grids
init_grid
%
%% Define initial condition
def_signal
add_mask

get_initial_deriv

figure;
surf(x,y,real(signal),'LineStyle','none')

% reshape the initial condition
reshape_initial_condition
%% Define depth function

obstacle = 0.6*exp(-R.^2);
h = 1 - obstacle;
hold on
surf(x,y,-h,'LineStyle','none')
zlim([-1,2])
xlim([-Lx/3,Lx/3])
ylim([-Ly,Ly])
caxis([-1 0.7])
view(-40,10)
%%
odef = @(t,z) odefun2D_linear(t,x,y,z,h);
%% Clear some variable to save space
clear R
clear signal
clear z0
clear signal_flat
clear z0_flat
clear X
clear Y
%%
[t,sol] = ode45(odef,[0 8],ic);
sol_phi = sol(:,1:prod([length(x) length(y)]));
%%
sol_phi = reshape(sol_phi,size(sol_phi,1),length(y),length(x));
clear sol
return
%%
close all

for tt = 1:15:length(t)
    clf
surf(x,y,real(squeeze(sol_phi(tt,:,:))),'LineStyle','none')
hold on
surf(x,y,-h,'LineStyle','none')
%imagesc(x,y,real(squeeze(sol_phi(tt,:,:))))
zlim([-1,2])
xlim([-Lx/3,Lx/3])
ylim([-Ly,Ly])
caxis([-0.7 0.7])
view(-40,20)
drawnow
end
%%
for tt = 1:15:length(t)
    clf
imagesc(x,y,real(squeeze(sol_phi(tt,:,:))))
xlim([-Lx/3,Lx/3])
ylim([-Ly,Ly])
caxis([-0.7 0.7])

drawnow
end
%%

% interpolate signal on regular time grid in 2d
X = repmat(x,[length(t) 1]);
T_clean = repmat(t_clean,[length(x) 1])';
T = repmat(t',[length(x) 1])';
y2_clean = interp2(X,T,y,X,T_clean);

% create vec for frequency analysis
dt = t_clean(2)-t_clean(1);
Nt = length(t_clean);
dx = x(2)-x(1);
Nx = length(x);

sf =2*pi/dt;
freq =sf*(-((Nt-1)/2):((Nt-1)/2))/Nt;
sk =2*pi/dx;
kvec =sk*(-((Nx-1)/2):((Nx-1)/2))/Nx;


% Fourier transform
ft = fftshift(fft(yt_clean));
ft2 = fftshift(fft2(y2_clean))/prod(size(y2_clean));
% find freq
[~,loc] = max(abs(ft));
f_signal = freq(loc)

close all
figure;
plot(ktemp/2/pi,sqrt(abs(fun(abs(ktemp)))))
hold on
plot(ktemp/2/pi,sqrt(ktemp.*tanh(ktemp)))
hold on
plot(kx/2/pi,f_signal,'o')

figure
imagesc(kvec,freq,abs(ft2))
caxis([0.00001 max(max(abs(ft2)))])
hold on
plot(kvec,sqrt(abs(fun(abs(kvec)))),'r')
plot(kvec,-sqrt(abs(fun(abs(kvec)))),'r')

%%

figure(1)
for tt = 1:10:length(t_clean)
plot(real(y2_clean(tt,:)))
ylim([-1,1])
drawnow
end




