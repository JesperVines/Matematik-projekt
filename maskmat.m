% inter2D.m huvudfunktion

% �ppnar ett f�nster d�r man f�r klicka p� h�rnpunkter
% som i par bildar rektangelomr�den. D�refter skapas
% en maskmatris.
function [mask] = maskmat(image,matrix,numb)

figure
imshow(image,'InitialMagnification','fit')
[X,Y] = ginput(2 * numb);
close

% Avrundar de givna punkterna
X = round(X);
Y = round(Y);

[n,m] = size(matrix);

mask = sparse(zeros(n,m));
k = 2;

% S�tter alla element som finns inom de angivna rektanglarna
% till 1.
for q=1:numb
    for i=X(k-1,1):X(k,1)
        for j=Y(k-1,1):Y(k,1)
            mask(i,j) = 1;
        end
    end
    k = k + 2;
end

% Alla element med v�rdet 0 blir till 1 och alla andra element
% f�r v�rdet 0.
mask = mask == 0;
end


