function[Amask]=Circlemaskmaker(Xpoints, Ypoints, mask)

radius=(sqrt((Xpoints(1,1)-Xpoints(2,1))^2+(Ypoints(1,1)-Ypoints(2,1))^2));

for a=1:size(mask,1)
    for b=1:size(mask,2)
        if (a-Xpoints(1,1))^2+(b-Ypoints(1,1))^2<radius^2
            mask(b,a)=0;
        end
    end
end
Amask=mask;
end