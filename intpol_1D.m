% Interpolerar omr�de mellan flera pixlar i 1D
% Korrekt anrop med t.ex en bild "Testbild.png":
% ipol('Testbild.png')
function [] = intpol_1D(image)
% Klicka p� ett j�mnt antal pixlar, ordningen spelar ingen roll d�
% getcor-funktionen sorterar alla punkter i stigande ordning.
[mask_matrix,cor_matrix] = getcor(image); 

[Q] = inpol(mask_matrix,cor_matrix,image);


createpic_1D(Q) % Sparar bilden som "interpolpic.png"


% Tar in pixelv�rdesmatrisen "original" med dim. 1xnx3,
% interpolationsv�rdesmatrisen "intvector" med dim. 1xmx3 
% en maskmatris med dim. 1xnx1 samt start- och slutpunkt.

function [A] = intervec(a,b,original,intvector,mask)
% Tar in pixelv�rdesmatrisen "original" med dim. 1xnx3,
% interpolationsv�rdesmatrisen "intvector" med dim. 1xmx3 
% en maskmatris med dim. 1xnx1 samt start- och slutpunkt.
    
    
R = fusevec(a,b,original(:,:,1),intvector(:,:,1),mask);
G = fusevec(a,b,original(:,:,2),intvector(:,:,2),mask);
B = fusevec(a,b,original(:,:,3),intvector(:,:,3),mask);

A = cat(3,R,G,B);
end

function [S] = intpolvec(a,b,A)
% Interpolerar �ver ett omr�de
x = double(a);
y = double(b);

[n,m] = size(A);

Q = zeros(m,1);

Q(1,1) = -x;
Q(m,1) = -y;

S = (A\Q)';
end

function [mask_vector] = maskmatris_1D(start_point,end_point,vector)
% Skapar en maskmatris    
    
a = start_point;
b = end_point;
A = vector;

[n,m,q] = size(A);
for i=1:n
    for j=1:m
        for k=1:q
           if and( (j>a),(j<b) )
               A(i,j,k) = 0;
           else
               A(i,j,k) = 1;
           end
        end
    end
end
mask_vector = A;
end

function [mask_matrix,cor_matrix] = getcor(pic)
% Tar in en bildfil som indata och returnerar en maskmatris samt en
% koordinatmatris.
    
    
figure
imshow(pic,'InitialMagnification','fit')

% L�ter oss trycka interaktivt p� pixlar som vi vill interpolera �ver.
% Ordningen spelar ingen roll men det m�ste vara ett j�mnt antal pixlar,
% dvs. markera ett j�mnt antal pixlar i f�nstret.
% Det g�r bra att v�lja samma pixel tv� g�nger f�r att t.ex. bilda
% en maskmatris = [1 1 0 0 0 1 0 0 0 1 1 1].
[X] = getpts;
A = round(X);
A = sort(A);
A = A';
p = numel(A);

T = imread(pic);

[n,m,q] = size(T);

% Skapar en maskmatris utifr�n pixelkoordinater som angets i f�nstret.
counter = 1;
indx = 0;
mask_matrix = zeros(n,m,q);
while counter < p/2 + 1
    counter = counter + 1;
    indx = indx + 2;
    mask_matrix = maskmatris_1D(A(1,indx-1),A(1,indx),T)==0 + mask_matrix;
end

mask_matrix = mask_matrix==0;
cor_matrix = A;
close
end


function [A] = ipolmat(p)
% Skapar en interpolations-matris av storlek pxp
A1 = (-2).*eye(p);

v2 = [1];
u2 = repelem(v2,p-1);
A2 = diag(u2,1);
A3 = diag(u2,-1);

A = sparse(A1 + A2 + A3);
end

function [original_int] = inpol(mask_matrix,cor_matrix,image)

img_mat = double(imread(image));

% Beh�ver bara en radmatris av maskmatrisen.
mask = mask_matrix(:,:,1); 

dim_cor = numel(cor_matrix); % Antalet element i cor_matrix
cor = cor_matrix; % F�rkortar namnet s� det inte blir s� l�ngt

% Delar upp bilden i R G & B matriser
R = img_mat(:,:,1);
G = img_mat(:,:,2);
B = img_mat(:,:,3);

% Interpolerar �ver alla 0-element i maskmatrisen
% Stannar n�r den g�tt igenom alla "par" av start/slutpunkter
% som angets f�r bilden.
indx = 0;
counter = 1;
while ( counter < dim_cor/2 + 1 )
indx = indx + 2;
counter = counter + 1;

% Dessa �r de k�nda pixelv�rdena f�r varje f�rgspektra.
known_a1 = R(:,cor(1,indx-1));
known_b1 = R(:,cor(1,indx));

known_a2 = G(:,cor(1,indx-1));
known_b2 = G(:,cor(1,indx));

known_a3 = B(:,cor(1,indx-1));
known_b3 = B(:,cor(1,indx));

E1 = intpolvec(known_a1,known_b1,ipolmat(cor(1,indx)-(cor(1,indx-1) + 1)));
E2 = intpolvec(known_a2,known_b2,ipolmat(cor(1,indx)-(cor(1,indx-1) + 1)));
E3 = intpolvec(known_a3,known_b3,ipolmat(cor(1,indx)-(cor(1,indx-1) + 1)));

E = cat(3,E1,E2,E3); % Interpolerade omr�desmatrisen

img_mat = intervec(cor(1,indx-1),cor(1,indx),img_mat,E,mask);
end
% Tar in en maskmatris samt en koordinatmatris.
% Koordinatmatrisen inneh�ller alla index f�r start/slut-intervall
% i maskmatrisen.
original_int = img_mat;
end


function [T] = fusevec(a,b,original,intvec,mask)
% Ers�tter pixlar i bildmatrisen till interpolerade pixlar.
original = double(original);

[n,m] = size(original);

s = 1;

for i=1:n
    for j=a:b
        if ( mask(i,j) == 0 )
           original(i,j) = intvec(i,s);
           s = s+1;
        end
    end
end

T = original;
end


function [] = createpic_1D(img_matrix)
% Tar in en 1xnx3-matris och g�r om den till en bild.
% Konverterar bildmatrisen till ett format som g�r det m�jligt
% att visa bilden.
Y = uint8(img_matrix); 

% Visar den interpolerade bilden i ett f�nster med maximal f�rstoring
imshow(Y,'InitialMagnification','fit')

% Skriver bilden till "interpolpic.png".
imwrite(Y,'interpolpic.png')
end
end