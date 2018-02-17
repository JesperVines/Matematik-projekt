% ipol.m är huvudfunktion

% Ersätter original-pixlar med interpolerade pixlar.

function [T] = makevec(a,b,vec1,vec2)


vec1 = double(vec1); 

s = 1;

for j=(a+1):(b-1)
    vec1(1,j) = vec2(1,s);
    s = s + 1;
end
T = vec1;