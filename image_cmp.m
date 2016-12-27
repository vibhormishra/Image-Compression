%function image_cmp(filename, type) %filename must not contain extension

filename = 'sully';
type = 'bmp';

clc;
fullname = strcat(filename,'.',type);
A = double(imread(fullname));
img_size = size(A);
A = A ./ 255;
X = reshape(A, img_size(1) * img_size(2), 3); 
%X represents n-pixel image as a n*3 matrix, the 3 columns representing 
% Red, Green, Blue values respectively.
[K, candidates] = countCentroids(X);%K = number of centroids
max_iters = 10;
if (K < 64)
    centroids(1:K,:) = candidates(1:K,:);
else
    shuffle = randperm(size(X,1));
    centroids = X(shuffle(1:K), : );
end
 
% Run K-Means
[centroids, idx] = runkMeans(X, centroids, max_iters);
X_recovered = centroids(idx,:);
 
bitmapEncode2(filename, centroids, idx, img_size);
 
% Reshape the recovered image into proper dimensions
X_recovered = reshape(X_recovered, img_size(1), img_size(2), 3);
 
% Display the original image 
subplot(1, 2, 1);
imagesc(A); 
title('Original');
 
% Display compressed image side by side
subplot(1, 2, 2);
imagesc(X_recovered)
title(sprintf('Compressed, with %d colors.', K));
newname = strcat(filename,'_cmp.',type);
imwrite(X_recovered, newname,type);
 
%end
