% ipol.m är huvudfunktion

% Skapar en interpolations-matris av storlek pxp

function [A] = ipolmat(p)

v1 = [-2];
u1 = repelem(v1,p); % Skapar en 1xp-vektor med endast "-2" element
A1 = diag(u1); % Diagonaliserar ovanstående matris

v2 = [1];
u2 = repelem(v2,p-1);
A2 = diag(u2,1);
A3 = diag(u2,-1);

A = sparse(A1 + A2 + A3);