%% Define obstacle shape and convert it into water depth
obstacle = 0.6*exp(-R.^2);
h = 1 - obstacle;