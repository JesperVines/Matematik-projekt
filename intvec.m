% ipol.m �r huvudfunktion

% Interpolerar �ver ett omr�de

function [S] = intvec(a,b,A)

x = double(a);
y = double(b);

[n,m] = size(A);

Q = zeros(m,1);

Q(1,1) = -x;
Q(m,1) = -y;

S = (A\Q)';