% Flux

function flux=flu(signal)
	flux = signal(end)^2 - signal(1)^2;
	%flux = mean(diff(signal.^2));
end