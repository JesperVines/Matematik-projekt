% Interpolerar godtyckligt antal omr�den i 2D.
% Korrekt anrop: inter2D(image,numb)
% d�r "image" �r en bildfil och "numb" �r antalet
% rektanglar man vill interpolera �ver.

% T.ex: "inter2D('testbild.png',4)"
% �ppnar bilden "testbild.png" i ett f�nster
% och man f�r klicka p� 8 h�rnpunkter, d�r varje
% par av punkter bildar en rektangel. Sedan interpoleras
% de valda omr�dena och den interpolerade bilden visas.

% Observera att denna funktion interpolerar v�ldigt
% l�ngsamt f�r stora rektangelomr�den.
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

% S�tter ihop RGB-matriserna till en nxmx3-matris
int_image = cat(3,R_int,G_int,B_int);

% Konverterar matrisen till ett format som kan visas grafiskt
int_image = uint8(int_image);

% Visar bilden i ett f�nster
imshow(int_image)

% Sparar bilden till "interpolpic2D.png"
imwrite(int_image,'interpolpic2D.png');
end
