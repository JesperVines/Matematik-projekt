% ipol.m �r huvudfunktion

% Tar in en 1xnx3-matris och g�r om den till en bild.
function [] = createpic_1D(img_matrix)

% Konverterar bildmatrisen till ett format som g�r det m�jligt
% att visa bilden.
Y = uint8(img_matrix); 

% Visar den interpolerade bilden i ett f�nster med maximal f�rstoring
imshow(Y,'InitialMagnification','fit')

% Skriver bilden till "interpolpic.png".
imwrite(Y,'interpolpic.png')

