function[ans]=Circlemaskchooser(image)
imshow(image,'InitialMagnification','fit')
[X,Y] = ginput;

mask=ones((size(double(imread(image)),1)), (size(double(imread(image)),2)));
Circlemaskcontroller(X, Y, mask);
close