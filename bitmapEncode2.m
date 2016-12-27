function bitmapEncode2(filename, centroids, idx, img_size)
[row, col] = size(idx);
newcentroids = uint8(centroids * 255);
num_cluster = size(centroids,1);
file2 = strcat(filename, '.txt');
fid = fopen(file2,'w+','l','UTF-8');
fprintf(fid,'%c%c%c',img_size(1),img_size(2),num_cluster);
fprintf(fid,'%c',newcentroids);
i=1;
num_pixel=img_size(1)*img_size(2);
c=1;
centroids
while (i<=num_pixel)
    count=1;        
    for j=(i+1):row
        if(idx(i)==idx(j))
            count = count + 1;
        else            
            break;
        end
    end        
    %fprintf('i = %2d, ( idx(i), count) = %2d %2d\n',i,idx(i),count);
    asc(1,c) = char(idx(i));     
    asc(1,c+1) = char(count);           
    c = c+2;     
    i = j;
end
fprintf(fid,'%c',asc);
fclose(fid);
end

