% Funktionen tar in en bildfil samt en maskmatris och visar
% bildfilen i ett f�nster med en kant ritad enligt maskmatrisen.
% Denna funktion, tillsammans med funktionerna "mask_rect.m" och 
% "combmask.m", uppfyller "krav 10" i kravspecifikationen.
function [] = bound_mask(image,mask)

% G�r alla 1:or i maskmatrisen till 0:or och tv�rtom.
mask_inv = mask == 0;

% Tar en sparse-matris och konverterar den till en full matris.
S = full(mask_inv);

% Ber�knar omr�den som best�r av 1:or.
bound = bwboundaries(S);

% Ritar in en kant l�ngs omr�dena i maskmatrisen.
imshow(image)
hold on
visboundaries(bound)
end