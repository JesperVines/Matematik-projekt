% Interpolerar godtyckligt antal omr�den i 2D.
% Denna funktion, tillsammans med "intpol2D.m", uppfyller
% "krav 12" i kravspecifikationen.

% Korrekt anrop: inter2D(image,mask)
% d�r "image" �r en bildfil och "mask" �r en maskmatris
% av samma storlek som bilden.

% Ett korrekt anrop med en bild "testbild.png" samt en funktion
% "mask_rect" som skapar en maskmatris:
% inter2D('testbild.png',mask_rect('testbild.png')) �ppnar
% f�rst ett f�nster d�r "testbild.png" visas och anv�ndaren
% f�r klicka p� tv� h�rnpunkter som tillsammans bildar en 
% rektangel.
% Sedan interpoleras det angivna omr�det och en ny bild
% "interpolpic2D.png" visas i ett nytt f�nster.

% Observera att denna funktion interpolerar v�ldigt
% l�ngsamt f�r stora omr�den.
function [] = inter2D(image,mask)

% Konverterar bilden till en nxmx3-matris
T = double(imread(image));

% RGB-matriser
R = T(:,:,1)';
G = T(:,:,2)';
B = T(:,:,3)';

% Interpolerar RGB-matriserna
R_int = (intpol2D(mask',R))';
G_int = (intpol2D(mask',G))';
B_int = (intpol2D(mask',B))';

% S�tter ihop RGB-matriserna till en nxmx3-matris
int_image = cat(3,R_int,G_int,B_int);

% Konverterar matrisen till ett format som kan visas grafiskt
int_image = uint8(int_image);

% Visar bilden i ett f�nster
imshow(int_image)

% Sparar bilden till "interpolpic2D.png"
imwrite(int_image,'interpolpic2D.png')
end
