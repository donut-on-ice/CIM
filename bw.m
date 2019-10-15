% Bandwidth

function bandwidth = bw(absSpec, fs)
	centroid = sc(absSpec, fs);
	N = size(absSpec, 2);
	freqs = linspace(0, fs./2, N);
	absSpecSq = absSpec.^2;
	bandwidth = sqrt(sum((freqs - centroid).^2.*absSpecSq) ./ sum(absSpecSq));
end