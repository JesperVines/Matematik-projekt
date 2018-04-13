% Denna funktion reducerar antalet pixlar som behöver lagras
% i en bild för att återskapa den genom interpolering.

% Funktionen tar som input en bildfil samt en tolerans.
% Toleransen är ett numeriskt värde >= 0, ett större värde
% komprimerar bilden mer.

% Ett korrekt anrop med bilden "testbild.png" och toleransen 150
% är: comp('testbild.png',150)

% Output är en 3-dimensionell maskmatris.
function [mask_3D] = comp(image,tol)

A = imread(image);
S = double(A);

% Uppdelning av bilden i RGB-kanaler.
R = S(:,:,1);
G = S(:,:,2);
B = S(:,:,3);

% Komprimerar över RGB-kanalerna.
RI = func01(R,tol);
GI = func01(G,tol);
BI = func01(B,tol);

% Sätter ihop maskmatriserna till en 3-dimensionell matris.
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
