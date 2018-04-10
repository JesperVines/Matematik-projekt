function[out]=Circlemaskchooser(image)
imshow(image,'InitialMagnification','fit')
[X,Y] = ginput;

mask=ones((size(double(imread(image)),1)), (size(double(imread(image)),2)));
out = Circlemaskcontroller(X, Y, mask);
close