% ipol.m är huvudfunktion

% Öppnar en ruta där man kan trycka på två punkter och få
% dess x-koordinater.

function [A] = getcor(pic)

figure
imshow(pic,'InitialMagnification','fit')
[X] = getpts;
A = round(X);
A = A';
close