% Interpolerar godtyckligt antal områden i 2D.
% Korrekt anrop: inter2D(image,numb)
% där "image" är en bildfil och "numb" är antalet
% rektanglar man vill interpolera över.

% T.ex: "inter2D('testbild.png',4)"
% öppnar bilden "testbild.png" i ett fönster
% och man får klicka på 8 hörnpunkter, där varje
% par av punkter bildar en rektangel. Sedan interpoleras
% de valda områdena och den interpolerade bilden visas.

% Observera att denna funktion interpolerar väldigt
% långsamt för stora rektangelområden.
function [] = inter2D(image,numb)

% Konverterar bilden till en nxmx3-matris
T = double(imread(image));

% RGB-matriser
R = T(:,:,1)';
G = T(:,:,2)';
B = T(:,:,3)';

% Funktion som skapar maskmatrisen
mask = maskmat(image,R,numb);

% Interpolerar RGB-matriserna
R_int = (intpol2D(mask,R))';
G_int = (intpol2D(mask,G))';
B_int = (intpol2D(mask,B))';

% Sätter ihop RGB-matriserna till en nxmx3-matris
int_image = cat(3,R_int,G_int,B_int);

% Konverterar matrisen till ett format som kan visas grafiskt
int_image = uint8(int_image);

% Visar bilden i ett fönster
imshow(int_image)

% Sparar bilden till "interpolpic2D.png"
imwrite(int_image,'interpolpic2D.png');
end
