function[out]=Circlemaskcontroller(Xpoints, Ypoints, mask)
if size(Xpoints,1)==0;
    newmask=mask;
else
TwoXpoints=Xpoints(1:2,1);
TwoYpoints=Ypoints(1:2,1);
newmask=Circlemaskmaker(TwoXpoints, TwoYpoints, mask);
if size(Xpoints, 1)>2
    newmask = combmask(newmask, Circlemaskcontroller(Xpoints(3:end), Ypoints(3:end), newmask));
else newmask;
end
end
out = newmask;
end