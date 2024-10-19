function [p_tip,pivit_loc] = ToolCalib(R_track, p_track)
% TCP Pivot Calibration
% R_track is 3*3*n Rotation Matrix
% p_track is 3*n Translation Vector

ptnum = size(R_track,3); % Measurements Number
Rs = mx3cat([R_track,-eye(3,3).*ones(1,1,ptnum)]); % mx3cat: r*c*p to (r*p)*c Matrics
bs = Rs\reshape(-p_track,ptnum*3,1);

[p_tip,pivit_loc] = deal(bs(1:3),bs(4:6));
end