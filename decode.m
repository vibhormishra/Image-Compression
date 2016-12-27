function decode(filename)
close all;
%filename = 'C:\Users\Phalanx\Documents\Academics\MINI Project\v2.txt';
file2 = strcat(filename,'.txt');
fid = fopen(file2,'r+','l','UTF-8');
data = fscanf(fid,'%c');
data = double(data);
[m, n] = size(data);
encoded = zeros(1,2);
img_size = zeros(1,2);
img_size(1,1) = data(1,1);
img_size(1,2) = data(1,2);
c = data(1,3);
cluster = zeros(c,3);
for j=1:3
    for i=1:c
        cluster(i,j) = data(1,(j-1)*c+i+3);
    end
end
i = (j-1)*c + i + 4;
j=1;
while(i<n)
encoded(j,1) = data(1,i);
encoded(j,2) = data(1,i+1);
j = j+1;
i = i+2;
end
fclose(fid);
num_pixels = img_size(1)*img_size(2);
new_matrix = zeros(num_pixels,3);
i=1;
k=1;
while(k<=num_pixels)   
    new_matrix(k,1) = cluster(encoded(i,1),1);
    new_matrix(k,2) = cluster(encoded(i,1),2);
    new_matrix(k,3) = cluster(encoded(i,1),3);
    for j=1:encoded(i,2)-1        
        k = k + 1;
        new_matrix(k,1) = cluster(encoded(i,1),1);
        new_matrix(k,2) = cluster(encoded(i,1),2);
        new_matrix(k,3) = cluster(encoded(i,1),3);
    end
    k = k+1;
    i = i+1;
end
X_recovered = reshape(new_matrix, img_size(1), img_size(2), 3);
filter_imag(X_recovered);
 
end
