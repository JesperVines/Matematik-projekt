% Interpolerar område mellan flera pixlar i 1D
% Korrekt anrop med t.ex en bild "Testbild.png":
% ipol('Testbild.png')
function [] = ipol(image)
% Klicka på ett jämnt antal pixlar, ordningen spelar ingen roll då
% getcor-funktionen sorterar alla punkter i stigande ordning.
[mask_matrix,cor_matrix] = getcor(image); 

[Q] = inpol(mask_matrix,cor_matrix,image);


createpic_1D(Q) % Sparar bilden som "interpolpic.png"