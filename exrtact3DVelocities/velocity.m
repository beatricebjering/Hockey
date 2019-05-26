function [timeaxis,Velocity] = velocity(w,pixelLength,ZLength,Ice, nrOfframes, XValues, YValues, Point2track)
% In this function the velocity for each player is calculated. The timeaxis
% is also returned in order to create a velocity graph.


% Set constants
frameRate=w.FrameRate; % framerate
t=1/frameRate; % time between each frame
timeaxis=zeros([1,nrOfframes-1]);
Velocity.velocity=zeros([1,nrOfframes-1]);
Velocity.velocity2=zeros([1,nrOfframes-1]);
time=t;

for j=1:nrOfframes-1       
    % pixellength in each frame (meters)
    w1=pixelLength(1,j);
    w2=pixelLength(1,j+1);
   
    % xy movement, player1 (meters)
    x1= abs(Ice.ice(j,1)*w1 - Ice.ice(j+1,1)*w2);
    y1= abs(Ice.ice(j,2)*w1 - Ice.ice(j+1,2)*w2);
    
    % xy movement, player2 (meters)
    x3= abs(Ice.ice2(j,1)*w1 - Ice.ice2(j+1,1)*w2);
    y3= abs(Ice.ice2(j,2)*w1 - Ice.ice2(j+1,2)*w2);
    
    % Global motion (meters)
    x2= abs(XValues.xValues6(Point2track.Point2track6,j)*w1 - XValues.xValues6(Point2track.Point2track6,j+1)*w2);
    y2= abs(YValues.yValues6(Point2track.Point2track6,j)*w1 - YValues.yValues6(Point2track.Point2track6,j+1)*w2);
    
    
    % Local velocity calculation of player 1 (m/s)
    dx=abs(x1-x2)/t;
    dy=abs(y1-y2)/t;
    dz=abs(ZLength.zLength(1,j)-ZLength.zLength(1,j+1))/t;
    Velocity.velocity(1,j)=sqrt((dx.^2 + dy.^2+dz.^2));
    
    
    % Local velocity calculation of player 2 (m/s)
    dx2=abs(x3-x2)/t;
    dy2=abs(y3-y2)/t;
    dz2=abs(ZLength.zLength2(1,j)-ZLength.zLength2(1,j+1))/t;
    Velocity.velocity2(1,j)=sqrt((dx2.^2 + dy2.^2+dz2.^2));
    
    % timeaxis
    timeaxis(1,j)=time;
    time=time+t;
end
end



