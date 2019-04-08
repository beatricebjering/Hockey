function [zLength,zLength2]=depth(I3,posmatrix,posmatrix2,nrOfframes,p3)
% what i want to do here is to find from which direction we are looking on
% the ice in order to estimate the depth. 
% begin with projecting the images of the players on the ice and display
% it. 
%then determine the angle the camera is looing on the ice. 
%then estimate the depth from that angle.
% this should work when the camera isn't moving too much
%{
zLength=zeros(1,nrOfframes);
imshow(I3); 
title('insert point on the ice from which the camera is filming');
[x,y]=getpts
Pcamera =  [ 
x(1), y(1); 
];
%}
Pcamera=p3;
[w l d]=size(I3);
%real world coordinates in meter
% this is DEPENDING ON if it is NHL or SHL

% NHL
% length = 200' = 60.96m
% width = 85' = 25.91m

rinkPixelLength= 60.96/l;
rinkPixelWidth= 25.91/w;

% SHL + IIHF
% length = 60m, width = 30m

%rinkPixelLength= 60/l;
%rinkPixelWidth=30/w;

for i=1:nrOfframes
%calculate distance from the inserted point from the camera direction
%player1
xLength= abs(Pcamera(1,1)-posmatrix(i,1))*rinkPixelLength;
yLength= abs(Pcamera(1,2)-posmatrix(i,2))*rinkPixelWidth;
zLength(1,i)=sqrt(xLength.^2 + yLength.^2);

%player2
xLength2= abs(Pcamera(1,1)-posmatrix2(i,1))*rinkPixelLength;
yLength2= abs(Pcamera(1,2)-posmatrix2(i,2))*rinkPixelWidth;
zLength2(1,i)=sqrt(xLength2.^2 + yLength2.^2);

end
end

