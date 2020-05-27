function dYdt = odefun_on_obstacle_non_dispersive(t,r,Y,hfun)
%% This function compute the derivatives of Y which is a 2xN array.
% The N column represent the "lines" for each spatial point
% The 2 rows are the field and its derivative.
check_size = size(Y);
if check_size(2) ~= 1
    Y = transpose(Y);
end
%% Separate the data
N = length(Y);
y = Y(1:(N/2));
dydt = Y((N/2+1):end);

%% Perform spectral derivative
d2ydt2 = transpose(hfun(r)).*transpose(DERIV(@(var) var.^2,r,transpose(y)));

%% Store the derivatives
dYdt = [dydt; d2ydt2];