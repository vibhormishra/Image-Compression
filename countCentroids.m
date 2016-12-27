function [K, temp] = countCentroids(X)
K = 0;
temp = zeros(64,3);
s = size(X,1);
for i=1:s
    flag = 0;
    for k = 1:K
        if(sum( power( temp(k,:) - X(i,:), 2 ) ) == 0)
            flag = 1;
            break;
        end
    end
    if (flag == 0)
        K = K + 1; %count number of centroids required upto maximum of 64                
        temp(K,:) = X(i,:);
        if (K == 64)
            break;
        end        
    end
end
fprintf('Total centroids : %d \n',K);
end

