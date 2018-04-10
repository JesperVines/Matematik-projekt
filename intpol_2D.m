% Interpolerar godtyckligt antal områden i 2D.
% Denna funktion, tillsammans med "intpol2D.m", uppfyller
% "krav 12" i kravspecifikationen.

% Korrekt anrop: inter2D(image,mask)
% där "image" är en bildfil och "mask" är en maskmatris
% av samma storlek som bilden.

% Ett korrekt anrop med en bild "testbild.png" samt en funktion
% "mask_rect" som skapar en maskmatris:
% inter2D('testbild.png',mask_rect('testbild.png')) öppnar
% först ett fönster där "testbild.png" visas och användaren
% får klicka på två hörnpunkter som tillsammans bildar en 
% rektangel.
% Sedan interpoleras det angivna området och en ny bild
% "interpolpic2D.png" visas i ett nytt fönster.

% Observera att denna funktion interpolerar väldigt
% långsamt för stora områden.
function [] = intpol_2D(image,mask)

% Konverterar bilden till en nxmx3-matris
C = double(imread(image));

% RGB-matriser
R = C(:,:,1);
G = C(:,:,2);
B = C(:,:,3);

if ndims(mask) == 3
    M1 = mask(:,:,1);
    M2 = mask(:,:,2);
    M3 = mask(:,:,3);
    
    R_int = in_mat(R,M1);
    G_int = in_mat(G,M2);
    B_int = in_mat(B,M3);
else
    
% Interpolerar RGB-matriserna
R_int = in_mat(R,mask);
G_int = in_mat(G,mask);
B_int = in_mat(B,mask);
end




% Sätter ihop RGB-matriserna till en nxmx3-matris
int_image = cat(3,R_int,G_int,B_int);


% Konverterar matrisen till ett format som kan visas grafiskt
int_image = uint8(int_image);

% Visar den interpolerade bilden
imshow(int_image)


% Sparar bilden till "interpolpic2D.png"
imwrite(int_image,'interpolpic2D.png')

function [int_pic] = in_mat(img_mat,mask)

[row,col] = size(img_mat);

% Skapar kolonnvektorn med alla element i bild-matrisen.
knw_int = funct01(img_mat,mask);

% Interpolationsmatrisen
int_mat = funct02(mask);

% Interpolerar över de okända pixlarna i maskmatrisen
X = int_mat \ knw_int;

int_pic = reshape(X,[row,col]);


% Skapar vektorn innehållandes alla pixelvärden
function [knw_int] = funct01(img_mat,mask)

[row2,col2] = find(~mask);
knw = sparse(numel(row2),1);

for i1=1:numel(row2)
    if mask(row2(i1,1),col2(i1,1)+1) == 1
       knw(i1,1) = knw(i1,1) + img_mat(row2(i1,1),col2(i1,1)+1);
    end
end

for i2=1:numel(row2)
    if mask(row2(i2,1),col2(i2,1)-1) == 1
       knw(i2,1) = knw(i2,1) + img_mat(row2(i2,1),col2(i2,1)-1);
    end
end

for i3=1:numel(row2)
    if mask(row2(i3,1)+1,col2(i3,1)) == 1
       knw(i3,1) = knw(i3,1) + img_mat(row2(i3,1)+1,col2(i3,1));
    end
end
           
for i4=1:numel(row2)
    if mask(row2(i4,1)-1,col2(i4,1)) == 1
       knw(i4,1) = knw(i4,1) + img_mat(row2(i4,1)-1,col2(i4,1));
    end
end

knw_int = -knw;

Z1 = find(~mask);
N1 = img_mat(:);

for i5=1:numel(Z1)
    N1(Z1(i5,1),1) = knw_int(i5,1);
end

knw_int = N1;

end

% Skapar koefficientmatrisen
function [mask_int] = funct02(mask)

[n,m] = size(mask);

unk = find(~mask);

% Skapar en sparse identitetsmatris
T = spalloc((n*m),(n*m),(n*m) + 4*numel(unk));

T(1:(n*m)+1:end)=1;

for i=1:numel(unk)
    T(unk(i,1),unk(i,1)) = -4;
    T(unk(i,1),unk(i,1)-n) = ~isempty(find(unk == unk(i,1)-n,1));
    T(unk(i,1),unk(i,1)+n) = ~isempty(find(unk == unk(i,1)+n,1));
    T(unk(i,1),unk(i,1)-1) = ~isempty(find(unk == unk(i,1)-1,1));
    T(unk(i,1),unk(i,1)+1) = ~isempty(find(unk == unk(i,1)+1,1));
end

mask_int = T;
end
end
end
