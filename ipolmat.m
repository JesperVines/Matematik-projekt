% ipol.m är huvudfunktion

% Skapar en interpolations-matris av storlek pxp
function [A] = ipolmat(p)

A1 = (-2).*eye(p);

v2 = [1];
u2 = repelem(v2,p-1);
A2 = diag(u2,1);
A3 = diag(u2,-1);

A = sparse(A1 + A2 + A3);