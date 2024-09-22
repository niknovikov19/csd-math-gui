function [w,f] = fft_smart(x,t)

% T = 2;
% N = 10000;
% f = 10;
% A = 1;
% phi = 0;
% n = 4;

N = length(t);

% Sampling period and rate
dt = t(2)-t(1);
fs = 1 / dt;

% FFT
nfft = 2^nextpow2(N);
w = fft(x,nfft)/N;
w = w(1:nfft/2+1);
f = fs/2*linspace(0,1,nfft/2+1);

end

