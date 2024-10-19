function T = ForceRot(T0,type)
% Numerical Value from Sensor may have Error
% Force to be a Rotation
% type: 'm' or 'q'
% m: 3*3*n or 4*4*n Matrix
% q: n*4 Quaternions

if strcmpi(type,'m')
[r,~,p] = size(T0);

if r==3
    R = T0;
elseif r==4
    R = T0(1:3,1:3,:);
end
T = T0;

for i = 1:p
    [U,~,V] = svd(R(:,:,i));
    T(1:3,1:3,i) = U*V';
end
elseif strcmpi(type,'q')
    T = T0./sqrt(sum(T0.^2,2));
end

end