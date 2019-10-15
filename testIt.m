function testIt(knownData, scale, sMaxEnd)
	k = 11;
	msg = "This sound is from a ";
	for i = 1:4
	
		[s, fs] = audioread(["sounds/test_" num2str(i, "%02d") ".wav"]);
		sEnd = size(s, 1);
		s = s(1:min(sEnd, sMaxEnd), 1)';
		testData = getSoundCoords(s, fs);
		testData(1, 1:7) = testData(1, 1:7) ./ scale;
		
		switch (kNN(knownData, testData, k))
			case 1
				disp([msg "guitar!"]);
			case 2
				disp([msg "piano!"]);
			case 3
				disp([msg "tambourine!"]);
			case 4
				disp([msg "saxophone!"]);
		end
	end
end