% Funktionen skapar en maskmatris av samma storlek som bilden.
% Tillsammans med funktionerna "bound_mask.m" och "combmask.m"
% uppfyller dessa "krav 10" i kravspecifikationen.

% T.ex: mask_rect('testbild.png') �pnnar bilden
% "testbild.png" i ett f�nster och l�ter dig trycka p� ett godtyckligt
% antal h�rnpunkter. D�refter skapas en maskmatris.
function [mask] = mask_rect(image)

figure
imshow(image,'InitialMagnification','fit')
[X,Y] = ginput;
close

if and(isempty(X),isempty(Y))
    Q = ones(size(double(imread(image))));
    mask = Q(:,:,1);
else

X = round(X);
Y = round(Y);

T = double(imread(image));

[n,m] = size(T(:,:,1));

mask = zeros(n,m);

D = numel(X) / 2;

k = 2;
for q=1:D
    for i=Y(k-1,1):Y(k,1)
        for j=X(k-1,1):X(k,1)
            mask(i,j) = 1;
        end
    end
    k = k + 2;
end

mask = mask == 0;
end
end