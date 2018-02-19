% ipol.m är huvudfunktion

% Tar in en 1xnx3-matris och gör om den till en bild.
function [] = createpic_1D(img_matrix)

% Konverterar bildmatrisen till ett format som gör det möjligt
% att visa bilden.
Y = uint8(img_matrix); 

% Visar den interpolerade bilden i ett fönster med maximal förstoring
imshow(Y,'InitialMagnification','fit')

% Skriver bilden till "interpolpic.png".
imwrite(Y,'interpolpic.png')

