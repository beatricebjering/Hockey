function [ZLength]=depth(I3,Posmatrix,nrOfframes,p3)
% What is done in this function is to find from which direction the camera
% is filming the ice, in order to estimate the depth. 
% This is done by taking the center of rotation of the camera (provided by
% the function homogrphy). The depth between the projected points on the
% ice (coordinates from the matrix Posmatrix) is estimated from this angle.

% Determine the size of the rink image
Pcamera=p3;
[w l d]=size(I3);

% Real world coordinates in meter, this is DEPENDING ON if it is NHL or SHL

% NHL
% length = 200' = 60.96m
% width = 85' = 25.91m

% SHL + IIHF
% length = 60m
% width = 30m

rinkPixelLength= 60/l;
rinkPixelWidth=30/w;

for i=1:nrOfframes
% Calculate distance from the inserted point from the camera direction

% player1
xLength= abs(Pcamera(1,1)-Posmatrix.posmatrix(i,1))*rinkPixelLength;
yLength= abs(Pcamera(1,2)-Posmatrix.posmatrix(i,2))*rinkPixelWidth;
ZLength.zLength(1,i)=sqrt(xLength.^2 + yLength.^2);

% player2
xLength2= abs(Pcamera(1,1)-Posmatrix.posmatrix2(i,1))*rinkPixelLength;
yLength2= abs(Pcamera(1,2)-Posmatrix.posmatrix2(i,2))*rinkPixelWidth;
ZLength.zLength2(1,i)=sqrt(xLength2.^2 + yLength2.^2);

end
end

