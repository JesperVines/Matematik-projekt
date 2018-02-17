% ipol.m är huvudfunktion

% Tar in tre matriser av samma storlek och skapar en bild

function [] = createpic(A,B,C)

E = cat(3,A,B,C); %Sätter ihop tre matriser till en nxmx3-matris
Y = uint8(E); 
imshow(Y,'InitialMagnification','fit')
imwrite(Y,'interpolpic.png')

