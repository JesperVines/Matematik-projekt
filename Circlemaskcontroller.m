%Tillsammans med Circlemaskchooser.m och Circlemaskmaker.m uppfyller
%denna krav 11 i kravspecifikationen.

%Circlemaskmaker tar x-värdena och y-värdena av några punkter, och en mask
%som argument.

%Den anropar sedan Circlemaskmaker med x- och y-värdena av de två första
%punkterna och sin mask. Sedan anropar den Circlemaskmaker med x- och
%y-värdena av den tredje och fjärde punkten (om de finns) tillsammans med
%masken som den fick förra gången den körde circlemaskmaker. På detta sätt
%fortsätter den tills den inte längre har två punkter att tillgå. Då
%returnerar den masken som den senast fick från Circlemaskmaker.

function[out]=Circlemaskcontroller(Xpoints, Ypoints, mask)
if size(Xpoints,1)<2;
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
