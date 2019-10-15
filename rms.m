% Root Mean Square

function res=rms(signal)
	res = sqrt(sum(signal.^2)./size(signal, 2));
end