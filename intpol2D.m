% inter2D.m huvudfunktion

% Tar in en bildmatris samt en maskmatris och interpolerar
% över de områden som specifierats i maskmatrisen.

% Hjälpfunktioner som "intpol2D" använder sig av
% är placerade längst ner i programmet.
function [int_pic] = intpol2D(mask,org_pic)

% Kolonnvektorn med kända pixlar
knw_int = func1(mask,org_pic);

% Interpolationsmatrisen
int_mat = func2(mask);

% Interpolerar över de okända pixlarna i maskmatrisen
X = int_mat \ knw_int;

[row1,col1] = find(~mask);

% Sätter in de interpolerade pixlarna på rätt plats
for i=1:numel(row1)
    org_pic(row1(i,1),col1(i,1)) = X(i,1);
end

int_pic = org_pic;

% Skapar en kolonnvektor med de kända pixelvärdena
function [knw_int] = func1(mask,org_pic)

[row2,col2] = find(~mask);
knw = sparse(zeros(1,numel(row2)))';

for i1=1:numel(row2)
    if mask(row2(i1,1),col2(i1,1)+1) == 1
       knw(i1,1) = knw(i1,1) + org_pic(row2(i1,1),col2(i1,1)+1);
    end
end

for i2=1:numel(row2)
    if mask(row2(i2,1),col2(i2,1)-1) == 1
       knw(i2,1) = knw(i2,1) + org_pic(row2(i2,1),col2(i2,1)-1);
    end
end

for i3=1:numel(row2)
    if mask(row2(i3,1)+1,col2(i3,1)) == 1
       knw(i3,1) = knw(i3,1) + org_pic(row2(i3,1)+1,col2(i3,1));
    end
end
           
for i4=1:numel(row2)
    if mask(row2(i4,1)-1,col2(i4,1)) == 1
       knw(i4,1) = knw(i4,1) + org_pic(row2(i4,1)-1,col2(i4,1));
    end
end

knw_int = -knw;
end


% Skapar interpolationsmatrisen för en godtycklig maskmatris
function [int_mat] = func2(mask)

[row,col] = find(~mask);
T = sparse(zeros(numel(row)));

for q=1:numel(row)
    for r=1:numel(row)
        if all([row(q,1) col(q,1)] == [row(r,1) col(r,1)])
            T(q,r) = 1;
        elseif all([row(q,1)-1 col(q,1)] == [row(r,1) col(r,1)])
            T(q,r) = 1;
        elseif all([row(q,1)+1 col(q,1)] == [row(r,1) col(r,1)])
            T(q,r) = 1;
        elseif all([row(q,1) col(q,1)-1] == [row(r,1) col(r,1)])
            T(q,r) = 1;
        elseif all([row(q,1) col(q,1)+1] == [row(r,1) col(r,1)])
            T(q,r) = 1;
        else
            T(q,r) = 0;
        end
    end
end

% Lägger till en diagonal med -4 som element
int_mat = T + (-5*eye(numel(row)));
end
end
            