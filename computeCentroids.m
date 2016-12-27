function centroids = computeCentroids(X, idx, K)
 
[m n] = size(X);
 
centroids = zeros(K, n);
 
for j=1:K
    [r,c]=find(idx==j);    
    centroids(j,:) = mean(X(r,:));
end
end
