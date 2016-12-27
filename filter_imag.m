function filter_imag(image_matrix)
h=3;
figure(h);
subplot(1,2,1);
imagesc(image_matrix/255)
title('Compressed image');
img_size = size(image_matrix);
X = reshape(image_matrix,img_size(1)*img_size(2),3);
[r,c] = size(X);
s = 3;
s2 = 2;
hashed = zeros(1,60);
for i=1:r-s2               
    x1 = i;
    x2 = i+s2;
    d = sum((X(x1,:) - X(x2,:)).^ 2);
    if( d >= 6000)
        continue;
    end
    hashed(1+fix(d/100)) = hashed(1+fix(d/100)) + 1;
end
sumh = 0;
for i=5:60
    sumh = sumh + hashed(i)*i;
end
sumh = sumh / sum(hashed(5:60));
hashed
theta1 = fix(sumh * 100) 
if(hashed(1)>200000)
    s = 6;    
end
for i=1:r-s2*img_size(1)               
    x1 = i;
    x2 = i+s2*img_size(1);
    d = sum((X(x1,:) - X(x2,:)).^ 2);
    if( d >= 6000)
        continue;
    end
    hashed(1+fix(d/100)) = hashed(1+fix(d/100)) + 1;
end
sumh = 0;
for i=5:60
    sumh = sumh + hashed(i)*i;
end
sumh = sumh / sum(hashed(5:60));
hashed
theta2 = fix(sumh * 100) 
if(hashed(1)>200000)
    s=6;
end
fprintf('s = %d\n',s)
if(s==6) % t = number of pixels to skip between two consecutive scans
        t=s;
    elseif(s==3)
        t=1;
end
 
for outer = 1:2 % do repeated vertical and horizontal smoothing

    for i=1:r-s*img_size(1) %horizontal smoothing
        x1 = i;
        x2 = i + s*img_size(1);
        d = sum((X(x1,:) - X(x2,:)).^ 2);
        d2 = sum((X(i,:) - X(i+fix(s*img_size(1)/3),:)).^ 2);        
        d3 = sum((X(i,:) - X(i+fix(2*s*img_size(1)/3),:)).^ 2);        
        if((abs(d) < theta2) && (abs(d2) < theta2) && (abs(d3) < theta2))        
            for k = x1:img_size(1):x2
%moving in steps of img_size(1) is same as traversing pixel in a row
                X(k,:) = ( X(x1,:)*(x2-k) + X(x2,:)*(k-x1) ) / (x2 - x1);
            end
        end        
    end    

    for i=1:t:r-s   %vertical smoothing            
        x1 = i;
        x2 = i+s;
        d = sum((X(x1,:) - X(x2,:)).^ 2);        
        d2 = sum((X(x1,:) - X(i+fix(s/3),:)).^ 2);        
        d3 = sum((X(x1,:) - X(i+fix(2*s/3),:)).^ 2);        
        if((abs(d) < theta1) && (abs(d2) < theta1) && (abs(d3) < theta1))        
            for k = x1:x2 
%moving in steps of 1 is same as traversing pixel column wise
                X(k,:) = ( X(x1,:)*(x2-k) + X(x2,:)*(k-x1) ) / (x2 - x1);
            end
        end           
    end
 theta1 = 0.7 * theta1; 
 theta2 = 0.7 * theta2;
end
subplot(1,2,2);
image_matrix = reshape(X, img_size(1,1),img_size(1,2),3);
imagesc(image_matrix/255)
title('Recovered Image');
end
