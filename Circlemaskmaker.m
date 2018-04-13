%Tillsammans med Circlemaskcontroller.m och Circlemaskchooser.m uppfyller
%denna krav 11 i kravspecifikationen.

%Circlemaskmaker tar x-värdena och y-värdena av två punkter representerade 
%som kolonnvektorer, och en maskmatris som argument. Den första punkten är 
%alltså första värdet i Xpoints kombinerad med första värdet i Ypoints och 
%den andra punkten blir andra värdet i Xpoints kombinerad med andra värdet 
%i Ypoints.

%Den tolkar sedan den första punkten som indexkoordinaterna i masken för
%mitten av en cirkelskiva, och den andra punkten som indexkoordinaterna i
%masken för en randpunkt på cirkelskivan. Den sätter sedan alla
%indexkoordinater i maskmatrisen som är inre punkter i cirkelskivan till 0
%och returnerar den nya masken.

function[Amask]=Circlemaskmaker(Xpoints, Ypoints, mask)

radius=(sqrt((Xpoints(1,1)-Xpoints(2,1))^2+(Ypoints(1,1)-Ypoints(2,1))^2));

for a=1:size(mask,2)
    for b=1:size(mask,1)
        if (a-Xpoints(1,1))^2+(b-Ypoints(1,1))^2<radius^2
            mask(b,a)=0;
        end
    end
end
Amask=mask;
end
