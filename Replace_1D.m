%I dagsläget fungerar bara koden för det första noll-intervallet i
%maskmatrisen. Jag ska försöka utöka det till att fungera för alla
%noll-intervall i maskmatrisen.

%"value_matrix" är här en tredimensionell exempelmatris där dess olika 
%element i dess tre olika plan motsvarar pixelvärden i en varje färg. Även 
%kallad "pixelvärdesmatrisen". Första planet ([:,:,1]) R för röd. Andra 
%planet ([:,:,2]) G för grön. Tredje planet ([:,:,3]) B för blå. Detta 
%mönster kommer följas i resten av koden.

value_matrix(:,:,1)=[1 2 3 4 5 100 100 100 100 10 11 12 13 14 15 16];
value_matrix(:,:,2)=[16 15 14 13 12 100 100 100 100 7 6 5 4 3 2 1];
value_matrix(:,:,3)=[50 50 50 50 50 100 100 100 100 50 50 50 50 50 50 50];

value_matrixR=value_matrix(:,:,1)
value_matrixG=value_matrix(:,:,2)
value_matrixB=value_matrix(:,:,3)

%"mask_matrix" är motsvarande exempelmatris där elementen är 0 om vi ska
%interpolera över dem, och 1 om vi inte ska det. Ska alltså ersättas med
%Anders funktion.
mask_matrix=[1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1];

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
%mask-radmatrisen och returnerar numreringen på dess kolonn som last_zero.

m=first_zero;
F(m)=mask_matrix(1,m);
while F(m)==0;
    m=m+1;
    F(m)=mask_matrix(1,m);
end
last_zero=m-1;

%Interpolationsmatris är ett exempel för när vi har fyra nollor i rad i
%maskmatrisen. Ska senare ersättas med Jespers kod som ska skapa en
%interpolationsmatris med nxn element om vi har n nollor i rad i
%maskmatrisen.

interpolationsmatris = [-2 1 0 0 ; 1 -2 1 0 ; 0 1 -2 1 ; 0 0 1 -2];

%randvardesmatris är radmatrisen som har randvärdena fast negativa som
%första och sista element och resten nollor

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
value_matrix

mask_matrix(1,first_zero:last_zero)=ones;

%Tanken är att denna funktion ska köras igen och igen tills maskmatrisen
%bara består av ettor men jag är inte tillräckligt duktig på Matlab för att 
%klara av det än. Men jag jobbar på det.