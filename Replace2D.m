%Tar en bild som argument och anropar intpol_2D tillsammans med bilden och
%en kombinerad maskmatris av mask_rect med bilden som argument och
%Circlemaskchooser med bilden som argument.
%combmask kombinerar som så att om det finns en nolla på en viss plats i
%någon av matriserna så blir det en nolla på den platsen. Om det på en viss 
%plats i matriserna finns ettor i båda matriserna så blir det en etta.

function[]=Replace2D(image)

intpol_2D(image, combmask(mask_rect(image), Circlemaskchooser(image)))
end
