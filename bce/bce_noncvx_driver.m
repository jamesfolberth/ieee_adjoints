%close all;
clear all;

%rng(0);

% Mark Schmidt's L1General
cd 'L1General'
addpath(genpath(pwd));
cd ..

% data files
%XXX: These aren't included in the repository, as the data do not belong to us.
%     One should be able to modify this (and the objective) to suit their puposes, however. 
s = load('data/Source Waveform - Impulsive.mat');
S = load('data/Impulsive Data.mat');

nc = 2; % number of channels

h_true = S.hTrue(1:nc,:).';
K_true = size(h_true,1);

m_true = (s.s).';
N_true = length(m_true);

n_zpd = 150;
h_true = [zeros(n_zpd,nc); h_true];
K_true = K_true + n_zpd;

% noise with std 0.005 is what Brendan used in his simulations
y = zeros(K_true+N_true-1, nc);
for i=1:nc
   y(:,i) = conv(h_true(:,i), m_true) + 0.005*randn(K_true+N_true-1,1);
end

% Estimate the IR length and source length
offset = -50;
K = K_true+offset
N = N_true-offset

% l1 terms
lambda_h = 1e-1;
lambda_m = 1e-2;
lambda = [lambda_h*ones(K*nc,1); lambda_m*ones(N,1)];

% TV (approx via huber) terms
lambda_h_TV = 1e-2;
huber_d = 0.1;

objective = @(x) bce_noncvx_objective(x, nc, K, N, y, lambda_h_TV, huber_d);

h0 = randn(K,nc); m0 = randn(N,1); x0 = [h0(:); m0];
y0 = zeros(K+N-1,nc);
for i=1:nc
   y0(:,i) = conv(h0(:,i), m0);
end
fprintf(1, 'inital convolution l2-error (rel) = %e\n', norm(y-y0,'fro')/norm(y,'fro'));

opts = {};
opts.maxIter = 10000;
opts.optTol = 1e-3;
opts.verbose = 1;

x_est = L1General2_PSSgb(objective, x0, lambda, opts);
%x_est = L1General2_PSSsp(objective, x0, lambda, opts);
%x_est = L1General2_BBSG(objective, x0, lambda, opts);
h_est = reshape(x_est(1:nc*K), [K nc]);
m_est = x_est(nc*K+1:nc*K+N);

y_est = zeros(K+N-1,nc);
for i=1:nc
   y_est(:,i) = conv(h_est(:,i), m_est);
end

fprintf(1, 'inital convolution l2-error (rel) = %e\n', norm(y-y0,'fro')/norm(y,'fro'));
fprintf(1, 'convolution l2-error (rel) = %e\n', norm(y-y_est,'fro')/norm(y,'fro'));

plot_channel = 1;
figure(1);
subplot(2,1,1);
plot(h_true(:,plot_channel), 'LineWidth', 1.5);
xlim([0 max(size(h_true,1), size(h_est,1))])
title('h\_true');
subplot(2,1,2);
plot(h_est(:,plot_channel), 'LineWidth', 1.5);
xlim([0 max(size(h_true,1), size(h_est,1))])
xlabel('index')
title('h\_est');

figure(2);
N = size(h_true,1);
subplot(2,1,1);
plot(m_true, 'LineWidth', 1.5);
xlim([0 max(size(m_true,1), size(m_est,1))])
title('s\_true');
subplot(2,1,2);
plot(m_est, 'LineWidth', 1.5);
xlim([0 max(size(m_true,1), size(m_est,1))])
xlabel('index')
title('s\_est');

figure(3);
subplot(2,1,1);
plot(y(:,plot_channel), 'LineWidth', 1.5);
title('x\_true');
subplot(2,1,2);
plot(y_est(:,plot_channel), 'LineWidth', 1.5);
xlabel('Time index')
title('x\_est = conv(h\_est, s\_est)');

