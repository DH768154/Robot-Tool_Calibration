function R = Q2R(q)
% Input q: n*4 row vector [v0,v123]
% return R : 3*3*n rotation matrix to Quaternion

% q = [q0,q123];
[r,c] = size(q);

if r==4 && c==1
    q = q';
    r = 1;
else
    if c~=4
        error('q Must be Row Vector, n*4')
    end
end

[q0,q1,q2,q3] = deal(q(:,1),q(:,2),q(:,3),q(:,4));

if r==1
    R = NaN(3,3);

    R(1,1) = q0^2+q1^2-q2^2-q3^2;
    R(2,2) = q0^2-q1^2+q2^2-q3^2;
    R(3,3) = q0^2-q1^2-q2^2+q3^2;

    R(1,2) = 2*(q1*q2-q0*q3);
    R(1,3) = 2*(q1*q3+q0*q2);
    R(2,1) = 2*(q1*q2+q0*q3);
    R(2,3) = 2*(q2*q3-q0*q1);
    R(3,1) = 2*(q1*q3-q0*q2);
    R(3,2) = 2*(q2*q3+q0*q1);
else
    R = NaN(3,3,r);

    R(1,1,:) = q0.^2+q1.^2-q2.^2-q3.^2;
    R(2,2,:) = q0.^2-q1.^2+q2.^2-q3.^2;
    R(3,3,:) = q0.^2-q1.^2-q2.^2+q3.^2;

    R(1,2,:) = 2*(q1.*q2-q0.*q3);
    R(1,3,:) = 2*(q1.*q3+q0.*q2);
    R(2,1,:) = 2*(q1.*q2+q0.*q3);
    R(2,3,:) = 2*(q2.*q3-q0.*q1);
    R(3,1,:) = 2*(q1.*q3-q0.*q2);
    R(3,2,:) = 2*(q2.*q3+q0.*q1);    
end


end