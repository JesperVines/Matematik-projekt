% Tar in en maskmatris samt en koordinatmatris.
% Koordinatmatrisen innehåller alla index för start/slut-intervall
% i maskmatrisen.

% Exempel:
% mask_matrix = [1 1 1 0 0 0 1 1 0 0 1 1];
% med motsvarande
% cor_matrix = [3 7 8 11];

function [original_int] = inpol(mask_matrix,cor_matrix,image)

img_mat = double(imread(image));

% Behöver bara en radmatris av maskmatrisen.
mask = mask_matrix(:,:,1); 

dim_cor = numel(cor_matrix); % Antalet element i cor_matrix
cor = cor_matrix; % Förkortar namnet så det inte blir så långt

% Delar upp bilden i R G & B matriser
R = img_mat(:,:,1);
G = img_mat(:,:,2);
B = img_mat(:,:,3);

% Interpolerar över alla 0-element i maskmatrisen
% Stannar när den gått igenom alla "par" av start/slutpunkter
% som angets för bilden.
indx = 0;
counter = 1;
while ( counter < dim_cor/2 + 1 )
indx = indx + 2;
counter = counter + 1;

% Dessa är de kända pixelvärdena för varje färgspektra.
known_a1 = R(:,cor(1,indx-1));
known_b1 = R(:,cor(1,indx));

known_a2 = G(:,cor(1,indx-1));
known_b2 = G(:,cor(1,indx));

known_a3 = B(:,cor(1,indx-1));
known_b3 = B(:,cor(1,indx));

E1 = intpolvec(known_a1,known_b1,ipolmat(cor(1,indx)-(cor(1,indx-1) + 1)));
E2 = intpolvec(known_a2,known_b2,ipolmat(cor(1,indx)-(cor(1,indx-1) + 1)));
E3 = intpolvec(known_a3,known_b3,ipolmat(cor(1,indx)-(cor(1,indx-1) + 1)));

E = cat(3,E1,E2,E3); % Interpolerade områdesmatrisen

img_mat = intervec(cor(1,indx-1),cor(1,indx),img_mat,E,mask);
end

original_int = img_mat;