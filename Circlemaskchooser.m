%Tillsammans med Circlemaskcontroller.m och Circlemaskmaker.m uppfyller
%denna krav 11 i kravspecifikationen.

%Tar en bild som argument. Öppnar bilden och låter användaren trycka på 
%punkter på bilden. Anropar sedan Circlemaskcontroller med X- och
%Y-koordinaterna för punkterna man klickade på i bilden, och en matris
%med ettor med samma dimensioner som bildens pixeldimensioner. Returnerar
%vad Circlemaskcontroller returnerar.

function[out]=Circlemaskchooser(image)
imshow(image,'InitialMagnification','fit')
[X,Y] = ginput;

mask=ones((size(double(imread(image)),1)), (size(double(imread(image)),2)));
out = Circlemaskcontroller(X, Y, mask);
close
