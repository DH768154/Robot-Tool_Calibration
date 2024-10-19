function PlotFrame(T,varargin)
p = inputParser;
addParameter(p,'scale',1)
addParameter(p,'arrowsize',0)
addParameter(p,'linewidth',1)
addParameter(p,'frameind','')
addParameter(p,'style','-')
addParameter(p,'colorind',1)
addParameter(p,'text','on')
parse(p,varargin{:});
arrowsize = p.Results.arrowsize;
scale = p.Results.scale;
linewidth = p.Results.linewidth;
frameind = p.Results.frameind;
style = p.Results.style;
colorind = p.Results.colorind;
texton = p.Results.text;

r = [1,0,0;0.8500 0.3250 0.0980;0.6350,0.0780,0.1840];
g = [0.1961,0.8039,0.1961;0.4660 0.6740 0.1880;0.1804,0.5451,0.3412];
b = [0.1,0.1,1;0 0.4470 0.7410;0,0,139/255];

if size(colorind,1)==3 % [rx,gx,bx;ry,gy,by;rz,gz,bz]
    r = [r;colorind(1,:)];
    g = [g;colorind(2,:)];
    b = [b;colorind(3,:)];
    colorind = 4;
end

if numel(T)==9
    T = R2T(T);
end

x = scale*[[0,0,0]',T(1:3,1)]+T(1:3,4);
y = scale*[[0,0,0]',T(1:3,2)]+T(1:3,4);
z = scale*[[0,0,0]',T(1:3,3)]+T(1:3,4);

xl = (1-arrowsize)*scale*[[0,0,0]',T(1:3,1)]+T(1:3,4);
yl = (1-arrowsize)*scale*[[0,0,0]',T(1:3,2)]+T(1:3,4);
zl = (1-arrowsize)*scale*[[0,0,0]',T(1:3,3)]+T(1:3,4);
plot3(xl(1,:),xl(2,:),xl(3,:),style,'Color',r(colorind,:),'LineWidth',linewidth);hold on
plot3(yl(1,:),yl(2,:),yl(3,:),style,'Color',g(colorind,:),'LineWidth',linewidth);hold on
plot3(zl(1,:),zl(2,:),zl(3,:),style,'Color',b(colorind,:),'LineWidth',linewidth);hold on

if arrowsize~=0
arrow3(arrowsize*scale,T,scale,[r(colorind,:);g(colorind,:);b(colorind,:)])
end

if strcmpi(texton,'on')
    text(x(1,2),x(2,2),x(3,2),['X',frameind],'FontWeight','bold','Color',r(colorind,:));hold on
    text(y(1,2),y(2,2),y(3,2),['Y',frameind],'FontWeight','bold','Color',g(colorind,:));hold on
    text(z(1,2),z(2,2),z(3,2),['Z',frameind],'FontWeight','bold','Color',b(colorind,:));hold on
end
end

function arrow3(h,T,scale,color3)
% Draw Arrow
r=[h*tand(15),0];
[x,y,z]=cylinder(r,20);
z = z*h;
z_1 = [x(1,:);y(1,:);z(1,:)];
z_2 = [x(2,:);y(2,:);z(2,:)];

ry = [0,0,1;0,1,0;-1,0,0];
x_1 = ry*z_1+[scale-h;0;0];
x_2 = ry*z_2+[scale-h;0;0];

rx = [1,0,0;0,0,1;0,-1,0];
y_1 = rx*z_1+[0;scale-h;0];
y_2 = rx*z_2+[0;scale-h;0];

z_1 = z_1+[0;0;scale-h];
z_2 = z_2+[0;0;scale-h];

x_1 = T*[x_1;ones(1,size(x_1,2))];
x_2 = T*[x_2;ones(1,size(x_2,2))];
y_1 = T*[y_1;ones(1,size(y_1,2))];
y_2 = T*[y_2;ones(1,size(y_2,2))];
z_1 = T*[z_1;ones(1,size(z_1,2))];
z_2 = T*[z_2;ones(1,size(z_2,2))];

mesh([x_1(1,:);x_2(1,:)],[x_1(2,:);x_2(2,:)],[x_1(3,:);x_2(3,:)],...
    'FaceColor',color3(1,:),'EdgeColor','none'); hold on
fill3(x_1(1,:),x_1(2,:),x_1(3,:),color3(1,:),'EdgeColor','none'); hold on
mesh([y_1(1,:);y_2(1,:)],[y_1(2,:);y_2(2,:)],[y_1(3,:);y_2(3,:)],...
    'FaceColor',color3(2,:),'EdgeColor','none'); hold on
fill3(y_1(1,:),y_1(2,:),y_1(3,:),color3(2,:),'EdgeColor','none'); hold on
mesh([z_1(1,:);z_2(1,:)],[z_1(2,:);z_2(2,:)],[z_1(3,:);z_2(3,:)],...
    'FaceColor',color3(3,:),'EdgeColor','none'); hold on
fill3(z_1(1,:),z_1(2,:),z_1(3,:),color3(3,:),'EdgeColor','none'); hold on

end