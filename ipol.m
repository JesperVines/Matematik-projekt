% Tog mig friheten att koda ihop en fungerande funktion.

% Interpolerar omr�de mellan tv� pixlar i 1D
% Korrekt anrop med t.ex en bild "Testbild.png":
% ipol('Testbild.png')
function [] = ipol(image)

X = getcor(image);  % Klicka p� tv� pixlar och sedan p� ENTER
T = imread(image); % G�r bild till matris

a = X(1,1); % start-index p� maskmatris
b = X(1,2); % slut-index p� maskmatris

A = ipolmat(b-(a+1)); % b-(a+1) �r antalet nollor i maskmatris

B = maskmatris_1D(a,b,T);


known_a1 = T(:,a,1); % k�nd start-pixel
known_b1 = T(:,b,1); % k�nd slut-pixel

known_a2 = T(:,a,2);
known_b2 = T(:,b,2);

known_a3 = T(:,a,3);
known_b3 = T(:,b,3);



E1 = intvec(known_a1,known_b1,createinterpolmatrix(b-(a+1)));
E2 = intvec(known_a2,known_b2,createinterpolmatrix(b-(a+1)));
E3 = intvec(known_a3,known_b3,createinterpolmatrix(b-(a+1)));

V1 = makevec(a,b,T(:,:,1),E1);
V2 = makevec(a,b,T(:,:,2),E2);
V3 = makevec(a,b,T(:,:,3),E3);

createpic(V1,V2,V3) % Sparar bilden som "interpolpic.png"