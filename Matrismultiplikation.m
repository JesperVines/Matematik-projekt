
values = input('What are your value for a0, aN and P? ');

a0 = values(1,1); aN = values(1,2); P = values(1,3);

B = bmatris(a0, aN, P); A = amatris(P);

disp(A\B)

function B = bmatris(a0, aN, P)
B = zeros(P,1);
B(1,1) = a0;
B(P,1) = aN;
end

function A = amatris(P)

A = zeros(P,P);

for p=1:1:P
    
    A(p,p) = -2;
    
    if p>1
       A(p,p-1) = 1;
    end
    
    if p<P
       A(p,p+1) = 1;
    end
end
end
