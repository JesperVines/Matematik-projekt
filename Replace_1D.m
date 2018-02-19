%Interpolerar i 1D �ver de omr�den som �r angivna som 0 i maskmatrisen.

%Replace 1D tar pixelv�rdesmatrisen och maskmatrisen som argument och
%interpolerar i 1D �ver de omr�den som �r 0 i maskmatrisen.
%Pixelv�rdesmatrisen kallas "value_matrix" och maskmatrisen kallas
%"mask_matrix".
%value_matrix har formatet 1xnx3 d�r [:,:,1] �r r�da pixelv�rden (R), 
%[:,:,2] �r gr�na pixelv�rden (G) och [:,:,3] �r bl� pixelv�rden (B).
%R, G och B kommer �terkomma p� fler st�llen i koden och betyder d� samma
%sak som h�r: R�tt, Bl�tt och Gr�nt

function[]=Replace_1D(value_matrix, mask_matrix)

%F�r att vi ska kunna interpolera �ver flera omr�den kommer funktionen
%f�rst verka p� det f�rsta nollintervallet i maskmatrisen. N�r den har
%gjort det ers�tter den nollintervallet i maskmatrisen med ettor och b�rjar
%om igen med den nya maskmatrisen. Detta upprepas tills maskmatrisen enbart
%inneh�ller ettor.

while ~isequal(mask_matrix, ones(size(mask_matrix)))
    
value_matrixR=value_matrix(:,:,1);
value_matrixG=value_matrix(:,:,2);
value_matrixB=value_matrix(:,:,3);

%Funktionen nedan letar efter den f�rsta nollan i mask-radmatrisen och 
%returnerar numreringen p� dess kolonn som first_zero.

position=1;
F(1)=mask_matrix(1,1);
while F(position)==1;
    position=position+1;
    F(position)=mask_matrix(1,position);
end
first_zero=position;

%Funktionen nedan letar efter f�rsta ettan efter f�rsta nollan i
%mask-radmatrisen och returnerar numreringen p� kolonnen f�re som 
%last_zero.

m=first_zero;
F(m)=mask_matrix(1,m);
while F(m)==0;
    m=m+1;
    F(m)=mask_matrix(1,m);
end
last_zero=m-1;

%Interpolationsmatris �r ett exempel f�r n�r vi har fyra nollor i rad i
%maskmatrisen. Den ska senare ers�ttas med Jespers kod som ska skapa en
%interpolationsmatris med nxn element om vi har n nollor i rad i
%maskmatrisen.

interpolationsmatris = [-2 1 0 0 ; 1 -2 1 0 ; 0 1 -2 1 ; 0 0 1 -2];

%randvardesmatris �r radmatrisen som har randv�rdena fast negativa som
%f�rsta och sista element och resten nollor.

randvardesmatrisR = zeros(1,(last_zero-first_zero+1));
randvardesmatrisR(1,1)=-(value_matrixR(1,(first_zero-1)));
randvardesmatrisR(1,(last_zero-first_zero+1))=-(value_matrixR(1,(last_zero+1)));

randvardesmatrisG = zeros(1,(last_zero-first_zero+1));
randvardesmatrisG(1,1)=-(value_matrixG(1,(first_zero-1)));
randvardesmatrisG(1,(last_zero-first_zero+1))=-(value_matrixG(1,(last_zero+1)));

randvardesmatrisB = zeros(1,(last_zero-first_zero+1));
randvardesmatrisB(1,1)=-(value_matrixB(1,(first_zero-1)));
randvardesmatrisB(1,(last_zero-first_zero+1))=-(value_matrixB(1,(last_zero+1)));

%replacement_matrix �r den radmatris som inneh�ller de v�rdena som vi vill
%ers�tta v�rdena i v�rt "skadade omr�de" med.

replacement_matrixR= round(randvardesmatrisR/transpose(interpolationsmatris));
replacement_matrixG= round(randvardesmatrisG/transpose(interpolationsmatris));
replacement_matrixB= round(randvardesmatrisB/transpose(interpolationsmatris));

%raderna nedan ers�tter v�rdena i pixelv�rdesmatrisen med v�ra 
%interpolerade v�rden, och nollorna som vi har interpolerat i maskmatrisen 
%med ettor.

value_matrixR(1,first_zero:last_zero)=replacement_matrixR;
value_matrixG(1,first_zero:last_zero)=replacement_matrixG;
value_matrixB(1,first_zero:last_zero)=replacement_matrixB;
value_matrix(:,:,1)=value_matrixR;
value_matrix(:,:,2)=value_matrixG;
value_matrix(:,:,3)=value_matrixB;

mask_matrix(1,first_zero:last_zero)=1;

value_matrix
end