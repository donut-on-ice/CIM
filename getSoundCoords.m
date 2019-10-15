% extracting coordonates based on signal, spectrum and sample rate

function coords=getSoundCoords(s, fs)

	absS = abs(fft(s));

	rate = zcr(s);
	gavg = rms(s);
	ener = ste(s);
	flux = flu(s);

	band = bw(absS, fs);
	cent = sc(absS, fs);
	pitc = pitch(absS, fs);
	coef = mel(s, fs);
	
	[N,M] = size(coef);
	
	coords = [rate, gavg, ener, flux, band, cent, pitc, norm(reshape(coef,[1, N*M])(1, 1:15))];

end