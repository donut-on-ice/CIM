function runTest

	% arbitrary sound window
	sMaxEnd = 6000;
	
	[knownData, scale] = getTrainingData(sMaxEnd);
	save("sounds/saved_known_data.mat", "knownData", "scale", "sMaxEnd");
	
	testIt(knownData, scale, sMaxEnd)
end