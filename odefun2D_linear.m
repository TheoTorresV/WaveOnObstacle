function dYdt = odefun2D_linear(t,x,y,z,h)
%% This function compute the derivatives of z which is a "Nx1 vector.
% The N first number are the field and the N last are the time derivative
% of the field.

check_size = size(z);
if check_size(2) ~= 1
    Y = transpose(z);
end

%% Separate the data
N = length(z);
phi = z(1:(N/2));
dphidt = z((N/2+1):end);

%% reshape the data
phi_mat = reshape(phi,[length(y) length(x)]);


%% Perform spectral derivative
d2zdt2 = h.*DERIV2D_linear(x,y,phi_mat);
d2phidt2 = d2zdt2(:);
%% Store the derivatives
dYdt = [dphidt; d2phidt2];