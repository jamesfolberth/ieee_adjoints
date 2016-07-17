function [] = make_figure()

big_fig = 'resolution_db1_sym_100_pinv.pgm';
tr_fig = big_fig;
br_fig = 'resolution_db1_sym_200_pinv.pgm';

big_fig = 'resolution_db1_sym_2500_adjoint.pgm';
tr_fig = big_fig;
br_fig = 'resolution_db1_sym_2500_pinv.pgm';

big_fig = 'resolution_bior4.4_sym_2500_adjoint.pgm';
tr_fig = big_fig;
br_fig = 'resolution_bior4.4_sym_2500_pinv.pgm';

region = [20 40 90 110];

bf = imread(big_fig);
tr = imread(tr_fig); tr = tr(region(2):region(4), region(1):region(3));
br = imread(br_fig); br = br(region(2):region(4), region(1):region(3));

[m,n] = size(bf);
tr = imresize(tr, [m/2, n/2], 'bicubic'); % m,n even
br = imresize(br, [m/2, n/2], 'bicubic'); % m,n even

X = [bf(1:m,1:n/2) [tr; br]];

% make a simple border
bw = 6; % border width
X(m/2-bw/2:m/2+bw/2,n/2:end) = 0;
X(:,n/2-bw/2:n/2+bw/2) = 0;

imshow(X,[])
%imshow(tr,[])
%imshow(bf,[])

imwrite(X, 'figure.pgm');

end
