function [Z] = v_pca(X,t,p,chunk)

[m,n,~] = size(X);
X = X(:,:,1:t);

X = permute(X, [2,1,3]);
X = reshape(X, m*n,t)';

X_0 = bsxfun(@minus, X, mean(X));

Z = zeros(size(X_0));
for i = 1 : t/chunk
    C = X_0((i-1)*chunk+1:i*chunk,:)'*X_0((i-1)*chunk+1:i*chunk,:);
    [Q,~,~] = svd(C,'econ');
    U = Q*X_0((i-1)*chunk+1:i*chunk,:)';
    Q(:,p+1:end) = 0;
    Z((i-1)*chunk+1:i*chunk,:) = (Q*U)';
end

Z = Z';
Z = reshape(Z,n,m,t);
Z = permute(Z,[2,1,3]);
end