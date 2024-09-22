function y = bandpass(x, fs, f1, f2, n)

if ~exist('n','var')
	n = 5;
end

y = x;

if f1
	[b1,a1] = butter(n, f1*2/fs, 'high');
	y = filtfilt(b1, a1, y);
end

if f2
	[b2,a2] = butter(n, f2*2/fs, 'low');
	y = filtfilt(b2, a2, y);
end

end

