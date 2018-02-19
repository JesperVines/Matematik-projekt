%Interpolerar i 1D över de områden som är angivna som 0 i maskmatrisen.

%Replace 1D tar pixelvärdesmatrisen och maskmatrisen som argument och
%interpolerar i 1D över de områden som är 0 i maskmatrisen.
%Pixelvärdesmatrisen kallas "value_matrix" och maskmatrisen kallas
%"mask_matrix".
%value_matrix har formatet 1xnx3 där [:,:,1] är röda pixelvärden (R), 
%[:,:,2] är gröna pixelvärden (G) och [:,:,3] är blå pixelvärden (B).
%R, G och B kommer återkomma på fler ställen i koden och betyder då samma
%sak som här: Rött, Blått och Grönt

function[]=Replace_1D(value_matrix, mask_matrix)

%För att vi ska kunna interpolera över flera områden kommer funktionen
%först verka på det första nollintervallet i maskmatrisen. När den har
%gjort det ersätter den nollintervallet i maskmatrisen med ettor och börjar
%om igen med den nya maskmatrisen. Detta upprepas tills maskmatrisen enbart
%innehåller ettor.

while ~isequal(mask_matrix, ones(size(mask_matrix)))
    
value_matrixR=value_matrix(:,:,1);
value_matrixG=value_matrix(:,:,2);
value_matrixB=value_matrix(:,:,3);

%Funktionen nedan letar efter den första nollan i mask-radmatrisen och 
%returnerar numreringen på dess kolonn som first_zero.

position=1;
F(1)=mask_matrix(1,1);
while F(position)==1;
    position=position+1;
    F(position)=mask_matrix(1,position);
end
first_zero=position;

%Funktionen nedan letar efter första ettan efter första nollan i
%mask-radmatrisen och returnerar numreringen på kolonnen före som 
%last_zero.

m=first_zero;
F(m)=mask_matrix(1,m);
while F(m)==0;
    m=m+1;
    F(m)=mask_matrix(1,m);
end
last_zero=m-1;

%Interpolationsmatris är ett exempel för när vi har fyra nollor i rad i
%maskmatrisen. Den ska senare ersättas med Jespers kod som ska skapa en
%interpolationsmatris med nxn element om vi har n nollor i rad i
%maskmatrisen.

interpolationsmatris = [-2 1 0 0 ; 1 -2 1 0 ; 0 1 -2 1 ; 0 0 1 -2];

%randvardesmatris är radmatrisen som har randvärdena fast negativa som
%första och sista element och resten nollor.

randvardesmatrisR = zeros(1,(last_zero-first_zero+1));
randvardesmatrisR(1,1)=-(value_matrixR(1,(first_zero-1)));
randvardesmatrisR(1,(last_zero-first_zero+1))=-(value_matrixR(1,(last_zero+1)));

randvardesmatrisG = zeros(1,(last_zero-first_zero+1));
randvardesmatrisG(1,1)=-(value_matrixG(1,(first_zero-1)));
randvardesmatrisG(1,(last_zero-first_zero+1))=-(value_matrixG(1,(last_zero+1)));

randvardesmatrisB = zeros(1,(last_zero-first_zero+1));
randvardesmatrisB(1,1)=-(value_matrixB(1,(first_zero-1)));
randvardesmatrisB(1,(last_zero-first_zero+1))=-(value_matrixB(1,(last_zero+1)));

%replacement_matrix är den radmatris som innehåller de värdena som vi vill
%ersätta värdena i vårt "skadade område" med.

replacement_matrixR= round(randvardesmatrisR/transpose(interpolationsmatris));
replacement_matrixG= round(randvardesmatrisG/transpose(interpolationsmatris));
replacement_matrixB= round(randvardesmatrisB/transpose(interpolationsmatris));

%raderna nedan ersätter värdena i pixelvärdesmatrisen med våra 
%interpolerade värden, och nollorna som vi har interpolerat i maskmatrisen 
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