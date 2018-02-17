function [mask] = CreateMask(start, stop, size, mask_matrix)
% Creates a mask matrix with zeroes between start and stop
% Takes start stop size and a previous mask_matrix. For a completely new mask use CreateMask(start, stop, size, ones(1, size)
	for i=start:1:stop
		mask_matrix(i)=0;
	end
	mask = sparse(mask_matrix);
end
