% Funktion som kombinerar 2 maskmatriser.
% Maskmatriserna måste ha samma dimension.

% Tillsammans med funktionerna "mask_rect.m" och "bound_mask.m"
% upfyller dessa "krav 10" i kravspecifikationen.
function [comb_mask] = combmask(mask_A,mask_B)

mask_A1 = mask_A == 0;
mask_B1 = mask_B == 0;

mask_C = mask_A1 + mask_B1;

comb_mask = mask_C == 0;
end