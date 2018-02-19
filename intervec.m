% ipol.m är huvudfunktion

% Tar in pixelvärdesmatrisen "original" med dim. 1xnx3,
% interpolationsvärdesmatrisen "intvector" med dim. 1xmx3 
% en maskmatris med dim. 1xnx1 samt start- och slutpunkt.

function [A] = intervec(a,b,original,intvector,mask)

R = fusevec(a,b,original(:,:,1),intvector(:,:,1),mask);
G = fusevec(a,b,original(:,:,2),intvector(:,:,2),mask);
B = fusevec(a,b,original(:,:,3),intvector(:,:,3),mask);

A = cat(3,R,G,B);