load('bootstrap.mat');
%load('lobby.mat');
%load('campus.mat');

X = video;

in = input('Set parameters: [t = #frames  p = #reconstruction rank  chunk = chunksize]\n');
t = in(1);  p = in(2);  chunk = in(3);

[Y_1] = v_svd(X,t,p,chunk);
[Y_2] = v_pca(X,t,p,chunk);

I_0 = implay(X);
set(I_0.Parent, 'Name', 'Original video')

I_1 = implay(Y_1);
set(I_1.Parent, 'Name', sprintf('Reconstruction from SVD using %d singular values',p))

I_2 = implay(Y_2);
set(I_2.Parent, 'Name', sprintf('Reconstruction from PCA using %d PCs',p))