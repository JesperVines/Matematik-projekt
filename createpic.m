% Tar in tre matriser av samma storlek och skapar en bild

function [] = createpic(A,B,C)

E = cat(3,A,B,C); %S�tter ihop tre matriser till en nxmx3-matris
Y = uint8(E);
imwrite(Y,'interpolpic.png')

