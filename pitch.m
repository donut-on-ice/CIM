% pitch by subharmonic sumation as described here:
% https://www.researchgate.net/publication/19813760_Measurement_of_pitch_by_subharmonic_summation

function p = pitch(absSpec, fs)

	pkg load signal;
	
	N = size(absSpec, 2);
	M = size(absSpec, 1);
	freqs = linspace(0, fs./2, N);
	
	h = 0.84;
	maxN = 15;
	
	% transform non picks +/- 2 to 0
	sharpSpec = zeros(M, N);
	for i = 1:M
		[~, peaksLoc] = findpeaks(absSpec(i, :));
		peaksArea = [peaksLoc - 2, peaksLoc - 1, peaksLoc, peaksLoc + 1, peaksLoc + 2];
		peaksArea = unique(peaksArea(peaksArea >= 1 & peaksArea <= N));
		sharpSpec(i, peaksArea) = absSpec(i, peaksArea);
	end
	
	% apply hanning window
	filterH = hann(N)'(ones(1, M),:);
	smoothSpec = sharpSpec .* filterH(ones(1,M),:);
	
	% apply raised arctan filter
	filterA = atan(freqs./5 - 5)./pi.*2 + 1;
	perfectSpec = smoothSpec .* filterA(ones(1,M),:);
	
	% summing subharmonics
	sumSubH = zeros(M, N);
	for n=1:maxN
		sumSubH = sumSubH + perfectSpec * n * h^n;
	end
	
	% getting the  for which sumSubH is maxim
	[~, freqLoc] = max(sumSubH, [], 2);
	p = freqs(:, freqLoc);
	
end