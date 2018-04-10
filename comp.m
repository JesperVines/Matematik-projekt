
function [mask_3D] = comp(image,tol)

A = imread(image);
S = double(A);

R = S(:,:,1);
G = S(:,:,2);
B = S(:,:,3);

RI = func01(R,tol);
GI = func01(G,tol);
BI = func01(B,tol);

mask_3D = cat(3,RI,GI,BI);

function [mask] = func01(img_mat,tol)

I = img_mat;

[row,col] = size(I);
D = zeros(row,col);

for i=2:(row - 1)
    for j=2:(col - 1)
        if abs(4*I(i,j)-I(i-1,j)-I(i+1,j)-I(i,j-1)-I(i,j+1)) > tol
            D(i,j) = 1;
        else
            D(i,j) = 0;
        end
    end
end

D(1,:) = 1;
D(:,1) = 1;
D(row,:) = 1;
D(:,col) = 1;

mask = D;
end
end