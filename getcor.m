% ipol.m �r huvudfunktion

% �ppnar en ruta d�r man kan trycka p� punkter och f�
% en maskmatris.
% ipol.m �r huvudfunktion

% Tar in en bildfil som indata och returnerar en maskmatris samt en
% koordinatmatris.
function [mask_matrix,cor_matrix] = getcor(pic)

figure
imshow(pic,'InitialMagnification','fit')

% L�ter oss trycka interaktivt p� pixlar som vi vill interpolera �ver.
% Ordningen spelar ingen roll men det m�ste vara ett j�mnt antal pixlar,
% dvs. markera ett j�mnt antal pixlar i f�nstret.
% Det g�r bra att v�lja samma pixel tv� g�nger f�r att t.ex. bilda
% en maskmatris = [1 1 0 0 0 1 0 0 0 1 1 1].
[X] = getpts;
A = round(X);
A = sort(A);
A = A';
p = numel(A);

T = imread(pic);

[n,m,q] = size(T);

% Skapar en maskmatris utifr�n pixelkoordinater som angets i f�nstret.
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