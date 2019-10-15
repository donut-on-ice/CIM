% this function is made after an interpretation of this tutorial:
% http://practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/

function coef=mel(s, fs)
	
	pkg load fuzzy-logic-toolkit;
	
	% for fs 44100Hz, 1000 frames are about 22.5 ms 
	windowSize = 1200;
	stepSize = 600;
	
	% number of fft points and frequence limits
	minFreq = 0;
	maxFreq = fs./2;
	nfft = 2048;
	linSpacedFreqs = linspace(minFreq, maxFreq, nfft/2 + 1);
	
	% arbitrary number between 26 and 40 of filterbanks
	% used to space out melFreqs
	filterbankNr = 26;
	
	% calculate the number of frames
	% but pad the input if needed
	pad = mod(size(s, 2) - windowSize, stepSize);
	s = [s,zeros(1,pad)]';
	framesNr = (size(s, 1) - windowSize + stepSize) / stepSize;
	
	% generate the hamming convolution
	hammingConvolution = hamming(windowSize);
	
	% si - original signal framed
	% Si - dft from the framed original signal 
	% Pi - periodigram for the framed dft
	
	si = zeros(windowSize, framesNr);
	Si = zeros(nfft/2 + 1, framesNr);
	Pi = zeros(nfft/2 + 1, framesNr);

	for i = 1:framesNr
	
		% get each frame and apply hamming
		iStart = (i - 1) * stepSize + 1; 
		iEnd = (i - 1) * stepSize + windowSize;
		si(:,i) = s(iStart:iEnd) .* hammingConvolution;
		
		% get the DFT for each frame; take first half of points
		Si(:,i) = fft(si(:,i), nfft)(1:nfft/2 + 1);
		
		% get the periodigram for each frame Pi = |Si|^2 / win_size
		Pi(:,i) = abs(Si(:,i)).^2 / windowSize;
		
	end

	% converting limits to mel scale
	melMinFreq = ms(minFreq);
	melMaxFreq = ms(maxFreq);

	% filterbank frequences in male scale 
	% which are then descaled
	melFreqs = linspace(melMinFreq, melMaxFreq, filterbankNr + 2);
	melSpacedFreqs = ims(melFreqs);

	% generating filgerbanks
	filterbanks = zeros(nfft/2 + 1, filterbankNr);
	for i=1:filterbankNr
		filterbanks(:,i) = trimf(linSpacedFreqs,[melSpacedFreqs(i), melSpacedFreqs(i+1), melSpacedFreqs(i+2)]);
	end

	% getting the matrix of mel cepstral coeficients
	% each row represents coeficients for one frame
	energySum = Pi' * filterbanks;
	coef = sum(dct(log10(energySum)));
	
end

% mel scaling
function y=ms(x)
	y = 1127 * log(1 + x/700);
end

% mel descaling
function y=ims(x)
	y = 700 * (exp(x/1127) - 1);
end