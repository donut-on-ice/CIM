% Short Term Energy

function energy = ste(signal)
	energy = sum(signal.^2)./size(signal, 2);
end