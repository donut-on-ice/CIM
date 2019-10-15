% Spectral Centroid

function centroid = sc(absSpec, fs)
	N = size(absSpec, 2);
	freqs = linspace(0, fs./2, N);
	absSpecSq = absSpec.^2;
	centroid = sum(freqs.*absSpecSq) ./ sum(absSpecSq);
end