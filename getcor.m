% ipol.m är huvudfunktion

% Öppnar en ruta där man kan trycka på punkter och få
% en maskmatris.
% ipol.m är huvudfunktion

% Tar in en bildfil som indata och returnerar en maskmatris samt en
% koordinatmatris.
function [mask_matrix,cor_matrix] = getcor(pic)

figure
imshow(pic,'InitialMagnification','fit')

% Låter oss trycka interaktivt på pixlar som vi vill interpolera över.
% Ordningen spelar ingen roll men det måste vara ett jämnt antal pixlar,
% dvs. markera ett jämnt antal pixlar i fönstret.
% Det går bra att välja samma pixel två gånger för att t.ex. bilda
% en maskmatris = [1 1 0 0 0 1 0 0 0 1 1 1].
[X] = getpts;
A = round(X);
A = sort(A);
A = A';
p = numel(A);

T = imread(pic);

[n,m,q] = size(T);

% Skapar en maskmatris utifrån pixelkoordinater som angets i fönstret.
counter = 1;
indx = 0;
mask_matrix = zeros(n,m,q);
while counter < p/2 + 1
    counter = counter + 1;
    indx = indx + 2;
    mask_matrix = maskmatris_1D(A(1,indx-1),A(1,indx),T)==0 + mask_matrix;
end

mask_matrix = mask_matrix==0;
cor_matrix = A;
close