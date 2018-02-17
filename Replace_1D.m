%I dagsl�get fungerar bara koden f�r det f�rsta noll-intervallet i
%maskmatrisen. Jag ska f�rs�ka ut�ka det till att fungera f�r alla
%noll-intervall i maskmatrisen.

%"value_matrix" �r h�r en tredimensionell exempelmatris d�r dess olika 
%element i dess tre olika plan motsvarar pixelv�rden i en varje f�rg. �ven 
%kallad "pixelv�rdesmatrisen". F�rsta planet ([:,:,1]) R f�r r�d. Andra 
%planet ([:,:,2]) G f�r gr�n. Tredje planet ([:,:,3]) B f�r bl�. Detta 
%m�nster kommer f�ljas i resten av koden.

value_matrix(:,:,1)=[1 2 3 4 5 100 100 100 100 10 11 12 13 14 15 16];
value_matrix(:,:,2)=[16 15 14 13 12 100 100 100 100 7 6 5 4 3 2 1];
value_matrix(:,:,3)=[50 50 50 50 50 100 100 100 100 50 50 50 50 50 50 50];

value_matrixR=value_matrix(:,:,1)
value_matrixG=value_matrix(:,:,2)
value_matrixB=value_matrix(:,:,3)

%"mask_matrix" �r motsvarande exempelmatris d�r elementen �r 0 om vi ska
%interpolera �ver dem, och 1 om vi inte ska det. Ska allts� ers�ttas med
%Anders funktion.
mask_matrix=[1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1];

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
%mask-radmatrisen och returnerar numreringen p� dess kolonn som last_zero.

m=first_zero;
F(m)=mask_matrix(1,m);
while F(m)==0;
    m=m+1;
    F(m)=mask_matrix(1,m);
end
last_zero=m-1;

%Interpolationsmatris �r ett exempel f�r n�r vi har fyra nollor i rad i
%maskmatrisen. Ska senare ers�ttas med Jespers kod som ska skapa en
%interpolationsmatris med nxn element om vi har n nollor i rad i
%maskmatrisen.

interpolationsmatris = [-2 1 0 0 ; 1 -2 1 0 ; 0 1 -2 1 ; 0 0 1 -2];

%randvardesmatris �r radmatrisen som har randv�rdena fast negativa som
%f�rsta och sista element och resten nollor

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
value_matrix

mask_matrix(1,first_zero:last_zero)=ones;

%Tanken �r att denna funktion ska k�ras igen och igen tills maskmatrisen
%bara best�r av ettor men jag �r inte tillr�ckligt duktig p� Matlab f�r att 
%klara av det �n. Men jag jobbar p� det.