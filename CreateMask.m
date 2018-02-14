function [mask] = CreateMask(start, stop, size)
	A = ones(1, size);
	for i=start:1:stop
		A(i)=0;
	end
	mask = sparse(A); % Vet inte om det har fungerar med ovriga funktioner
end
