% ipol.m �r huvudfunktion

% �ppnar en ruta d�r man kan trycka p� tv� punkter och f�
% dess x-koordinater.

function [A] = getcor(pic)

figure
imshow(pic,'InitialMagnification','fit')
[X] = getpts;
A = round(X);
A = A';
close