function[slutmatris]=cirkelmask(image)
imshow(image,'InitialMagnification','fit')
[X,Y] = ginput(2);
close
radius=(sqrt((X(1,1)-X(2,1))^2+(Y(1,1)-Y(2,1))^2));
storlek=size(double(imread(image)));
slutmatris=ones(storlek(1,1), storlek(1,2));
for a=1:storlek(1,1);
    for b=1:storlek(1,2);
        if (a-X(1,1))^2+(b-Y(1,1))^2<radius^2;
            slutmatris(a,b)=0;
        end
    end
end

end