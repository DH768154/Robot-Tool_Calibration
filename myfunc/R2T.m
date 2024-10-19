function T = R2T(R,varargin)

p = size(R,3);

if p == 1
    T = eye(4);
    if isa(R,'sym')
        T = sym(T);
    end
    
else
    T = zeros(4,4,p);
    T(4,4,:) = 1;
end

T(1:3,1:3,:) = R;

if nargin == 2
    T(1:3,4,:) = varargin{1};
end

end