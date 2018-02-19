% ipol.m är huvudfunktion

% Ersätter pixlar i bildmatrisen till interpolerade pixlar.
function [T] = fusevec(a,b,original,intvec,mask)

original = double(original);

[n,m] = size(original);

s = 1;

for i=1:n
    for j=a:b
        if ( mask(i,j) == 0 )
           original(i,j) = intvec(i,s);
           s = s+1;
        end
    end
end

T = original;