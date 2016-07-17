% A simple script to download and unzip various dependencies

% FISTA
% we use a slightly modified version of Beck+Teboulle's FISTA demo code
% you can get the original demo code with the following:
%fprintf('Fetching FISTA...\n')
%websave('FISTA.zip', 'https://web.iem.technion.ac.il/images/user-files/becka/papers/wavelet_FISTA.zip');
%fprintf('Unzipping FISTA...\n')
%mkdir('wavelet/FISTA')
%unzip('FISTA.zip', 'wavelet/FISTA')


% SSIM
fprintf('Fetching SSIM...\n')
websave('wavelet/ssim_index.m', 'https://ece.uwaterloo.ca/~z70wang/research/ssim/ssim_index.m');


% HNO
fprintf('Fetching HNO Toolbox...\n')
websave('HNO.zip', 'http://www.imm.dtu.dk/~pcha/HNO/HNO.zip');
fprintf('Unzipping HNO Toolbox...\n')
unzip('HNO.zip', 'wavelet/') % will make dir wavelet/HNO/


% L1General
fprintf('Fetching L1General...\n')
websave('L1General.zip', 'https://www.cs.ubc.ca/~schmidtm/Software/L1General.zip');
fprintf('Unzipping L1General...\n')
unzip('L1General.zip', 'bce/')
fprintf('mexing L1General...\n')
cd 'bce/L1General'
mexAll;
cd ../..

% export_fig
fprintf('Fetching export_fig...\n')
websave('export_fig.zip', 'https://github.com/altmany/export_fig/archive/master.zip');
fprintf('Unzipping export_fig...\n')
unzip('export_fig.zip', 'wavelet/')
movefile('wavelet/export_fig-master', 'wavelet/export_fig')

