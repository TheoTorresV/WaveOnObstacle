signal_flat = transpose(signal(:));
z0_flat = transpose(z0(:));
ic = transpose([signal_flat, z0_flat]);