function [mask] = CreateMask(start, stop, size)
% Creates a mask matrix with zeroes between start and stop
	A = ones(1, size);
	for i=start:1:stop
		A(i)=0;
	end
	mask = sparse(A); % Vet inte om det har fungerar med ovriga funktioner
end
