% getting trained data by reading the training wav files
% the program takes an arbitrary window from each sound to ensure length consistency

function [knownData, scale]=getTrainingData(sMaxEnd)

	knownData = [];

	for i=1:20
	
		[s, fs] = audioread(["sounds/guitar_" num2str(i, "%02d") ".wav"]);
		sEnd = size(s, 1);
		s = s(1:min(sEnd, sMaxEnd), 1)';
		data = [getSoundCoords(s, fs), 1];
		knownData = [knownData; data];
	
	end

	for i=1:20
		
		[s, fs] = audioread(["sounds/piano_" num2str(i, "%02d") ".wav"]);
		sEnd = size(s, 1);
		s = s(1:min(sEnd, sMaxEnd), 1)';
		data = [getSoundCoords(s, fs), 2];
		knownData = [knownData; data];
	
	end

	for i=1:20
		
		[s, fs] = audioread(["sounds/tambourine_" num2str(i, "%02d") ".wav"]);
		sEnd = size(s, 1);
		s = s(1:min(sEnd, sMaxEnd), 1)';
		data = [getSoundCoords(s, fs), 3];
		knownData = [knownData; data];
	
	end

	for i=1:20
		
		[s, fs] = audioread(["sounds/saxophone_" num2str(i, "%02d") ".wav"]);
		sEnd = size(s, 1);
		s = s(1:min(sEnd, sMaxEnd), 1)';
		data = [getSoundCoords(s, fs), 4];
		knownData = [knownData; data];
	
	end

	% scalling the data to the bigest 
	scale = max(abs(knownData(:,1:7)));
	knownData(:,1:7) = knownData(:,1:7) ./ scale(ones(1, size(knownData, 1)), :);
	
end