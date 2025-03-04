function lfp_csd_proc_2(params, is_first_call)

% Get parameters from GUI
unpack_params(params);

% Depths
yy = linspace(xmin, xmax, nchan);

% LFP amplitude profile
Q = (yy - A_mu).^2 / A_sigma^2;
A_vec = sqrt(1 - Q) .* (Q <= 1);

% LFP phase profile
phi_vec = phi_k * yy + phi_c * yy.^2;

tt = [0 : dt : T];
nt = length(tt);

% Generate LFP signal
LFP = zeros(nchan, nt);
for n = 1 : nchan
    LFP(n, :) = A_vec(n) * cos(2 * pi * f * tt + phi_vec(n));
end

% Calculate CSD signal
%LFP_ = [LFP(1,:); LFP; LFP(end,:)];
BIP = diff(LFP, 1, 1);
CSD = -diff(LFP, 2, 1);
BIP = [BIP; BIP(end,:)];
CSD = [CSD(1,:); CSD; CSD(end,:)];

% Allocate output structure
z = zeros(nchan, 1);
S = struct('lfp', struct(), 'bip', struct(), 'csd', struct());
for data_type = {'lfp', 'bip', 'csd'}
    S.(data_type{1}) = struct('A', z, 'phi', z);
end

% Calculate LFP/CSD amplitude and phase from the signals
for n = 1 : nchan
    [S.lfp.A(n), S.lfp.phi(n)] = calc_fresp(LFP(n, :), tt, f);
    [S.bip.A(n), S.bip.phi(n)] = calc_fresp(BIP(n, :), tt, f);
    [S.csd.A(n), S.csd.phi(n)] = calc_fresp(CSD(n, :), tt, f);
end
S.lfp.phi = -S.lfp.phi;
S.bip.phi = -S.bip.phi;
S.csd.phi = -S.csd.phi;

% Analytically compute CSD amplitude from LFP amplitude and phase
r = S.lfp.A;
dr = diff(r); dr = [dr(1); dr];
d2r = diff(r, 2); d2r = [d2r(1); d2r; d2r(end)];
phi = S.lfp.phi;
dphi = diff(phi); dphi = [dphi(1); dphi];
d2phi = diff(phi, 2); d2phi = [d2phi(1); d2phi; d2phi(end)];
r2_csd = d2phi.^2 .* r.^2 + 4 * d2phi .* dphi .* dr .* r +...
         d2r.^2 - 2 * d2r .* dphi.^2 .* r +...
         dphi.^4 .* r.^2 + 4 * dphi.^2 .* dr.^2;
r_csd = sqrt(r2_csd);

% Analytically compute BIP amplitude from LFP amplitude and phase
r2_bip = dr.^2 + r.^2 .* dphi.^2;
r_bip = sqrt(r2_bip);

p = 2;

col = 'b';

% Plot 2-d signals: depth x time
figure(111); clf;
subplot(3, 4, [1, 2]);
imagesc(tt, yy, LFP);
caxis(max(abs(LFP(:))) * [-1, 1]);
ylabel('Depth');
title('LFP');
colorbar;
subplot(3, 4, [5, 6]);
imagesc(tt, yy, BIP);
caxis(max(abs(BIP(:))) * [-1, 1]);
ylabel('Depth');
xlabel('Time');
title('BIP');
colorbar;
subplot(3, 4, [9, 10]);
imagesc(tt, yy, CSD);
caxis(max(abs(CSD(:))) * [-1, 1]);
ylabel('Depth');
xlabel('Time');
title('CSD');
colorbar;

% Plot LFP/BIP/CSD amplitude profiles
subplot(3, 4, 3);
x = S.lfp.A.^p / max(S.lfp.A.^p);
plot(x, yy, col);
xlim(minmax(x(:)'));
ylim([xmin, xmax]);
set(gca, 'YDir', 'reverse');
title('LFP amp.');
subplot(3, 4, 7); hold on;
x = S.bip.A.^p / max(S.bip.A.^p);
plot(x, yy, col);
%plot(r_bip.^p / max(r_bip.^p), yy, [col, '--'], 'LineWidth', 2);  % analytic result
%plot(flip(r_bip.^p) / max(S.bip.A.^p), yy, [col, '--'], 'LineWidth', 2);  % analytic result
plot(r_bip.^p / max(S.bip.A.^p), yy, [col, '--'], 'LineWidth', 2);  % analytic result
xlim(minmax(x(:)'));
ylim([xmin, xmax]);
set(gca, 'YDir', 'reverse');
title('BIP amp.');
subplot(3, 4, 11); hold on;
x = S.csd.A.^p / max(S.csd.A.^p);
plot(x, yy, col);
plot(r_csd.^p / max(r_csd.^p), yy, [col, '--'], 'LineWidth', 2);  % analytic result
xlim(minmax(x(:)'));
ylim([xmin, xmax]);
set(gca, 'YDir', 'reverse');
title('CSD amp.');

% Plot LFP/BIP/CSD phase profiles
subplot(3, 4, 4);
plot(S.lfp.phi, yy, col);
set(gca, 'YDir', 'reverse');
ylim([xmin, xmax]);
title('LFP phase');
subplot(3, 4, 8);
plot(S.bip.phi, yy, col);
set(gca, 'YDir', 'reverse');
ylim([xmin, xmax]);
title('BIP phase');
subplot(3, 4, 12);
plot(S.csd.phi, yy, col);
set(gca, 'YDir', 'reverse');
ylim([xmin, xmax]);
title('CSD phase');

end
