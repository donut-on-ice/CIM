% Zero Crossing Rate

function rate = zcr(signal)
	rate = mean(abs(diff(sign(signal))))./2;
end