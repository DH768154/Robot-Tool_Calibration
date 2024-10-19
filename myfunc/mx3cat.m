function Rout = mx3cat(Rin)
% r*c*p to (r*p)*c Matrics, for Least Square Use, Avoid Loop

% Rout = reshape(permute(Rin, [2 1 3]), size(Rin, 2), [])';

[r,c,p] = size(Rin);

Rout = reshape(pagectranspose(Rin),c,r*p)';
end
