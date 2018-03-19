% Uppfyller krav 11

% Skapar en maskmatris som svarar mot ett cirkulärt område.

% Funktionen tar en bild som argument och låter en klicka på två punkter på
% bilden. Den första punkten man klickar på blir cirkelnskivans centrum, 
% den andra punkten man klickar på blir en punkt på cirkelskivans rand.
 
% Returnerar sedan en maskmatris med cirkelskivas inre punkter som 0 och
% resterande punkter som 1

function[maskmatris]=cirkelmask(image)

%Storleken av bilden i "Bredd x Höjd x Djup"-format som radmatris
storlek=size(double(imread(image)));

%Visar bilden och låter en välja två punkter
imshow(image,'InitialMagnification','fit')
[X,Y] = ginput(2);
close

%Radien av cirkeln som utgörs av punkterna man har valt
radius=(sqrt((X(1,1)-X(2,1))^2+(Y(1,1)-Y(2,1))^2));

%Om en punkt ligger innanför cirkeln sätts motsvarande punkt i maskmatrisen
%till 0, annars sätts den till 1.
maskmatris=ones(storlek(1,1), storlek(1,2));
for a=1:storlek(1,1);
    for b=1:storlek(1,2);
        if (a-X(1,1))^2+(b-Y(1,1))^2<radius^2;
            maskmatris(a,b)=0;
        end
    end
end

end

