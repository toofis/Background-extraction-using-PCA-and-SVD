function [J] = v_svd(Y,t,p,chunk)

if mod(t,chunk)
    error('Chunk size must divide the number of frames')
end

[m,n,~] = size(Y); 
Y = Y(:,:,1:t);

Y = permute(Y, [2,1,3]);
Y = reshape(Y, m*n,t);

J = zeros(m*n,t);
for i = 1:t/chunk
    X = Y(:,(i-1)*chunk+1:i*chunk);
    [U,S,V] = svd(X);
    X = U(:,1:p)*S(1:p,1:p)*V(:,1:p)';
    J(:,(i-1)*chunk+1:i*chunk) = X;
end

J = reshape(J, n,m,t);
J = permute(J, [2,1,3]);
end