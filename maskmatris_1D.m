% ipol.m är huvudfunktion

% Skapar en maskmatris

function [mask_vector] = maskmatris_1D(start_point,end_point,vector)
a = start_point;
b = end_point;
A = vector;

[n,m,q] = size(A);
for i=1:n
    for j=1:m
        for k=1:q
           if and( (j>a),(j<b) )
               A(i,j,k) = 0;
           else
               A(i,j,k) = 1;
           end
        end
    end
end
mask_vector = A;