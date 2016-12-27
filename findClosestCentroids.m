function idx = findClosestCentroids(X, centroids)
 
K = size(centroids, 1);
 
idx = zeros(size(X,1), 1);
 
m = size(X,1);
for i=1:m
    dist = 10^6; %assign some random large value
    for j=1:K
        temp = sum( (X(i,:)-centroids(j,:)) .^ 2);
        if(temp < dist)            
            dist = temp;
            idx(i) = j;    
        end
    end
end
 
end
