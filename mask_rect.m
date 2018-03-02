% Funktionen skapar en maskmatris av samma storlek som bilden.
% Tillsammans med funktionerna "bound_mask.m" och "combmask.m"
% uppfyller dessa "krav 10" i kravspecifikationen.

% T.ex: mask_rect('testbild.png') �pnnar bilden
% "testbild.png" i ett f�nster och l�ter dig trycka p� tv�
% h�rnpunkter i en rektangel. D�refter skapas en maskmatris.
function [mask] = mask_rect(image)

figure
imshow(image,'InitialMagnification','fit')
[X,Y] = ginput(2);
close

X = round(X);
Y = round(Y);

T = double(imread(image));

[n,m] = size(T(:,:,1)');

mask = sparse(zeros(n,m));

for i=X(1,1):X(2,1)
    for j=Y(1,1):Y(2,1)
        mask(i,j) = 1;
    end
end

mask = mask == 0;
mask = mask';
end