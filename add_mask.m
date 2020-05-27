mask = zeros(size(signal));


mask = exp(-((X-Lx/2)/0.5).^2) + exp(-((X+Lx/2)/0.5).^2);
[~,loc] = findpeaks(mask(1,:));
mask(:,1:loc(1)) = 1;
mask(:,loc(2):end) = 1;


signal = signal.*mask;