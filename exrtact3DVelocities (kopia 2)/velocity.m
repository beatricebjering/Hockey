function [timeaxis,Velocity] = velocity(w,pixelLength,ZLength,Ice, nrOfframes, XValues, YValues, Point2track)
frameRate=w.FrameRate;
t=1/frameRate; %tiden för hela videon
timeaxis=zeros([1,nrOfframes-1]);
Velocity.velocity=zeros([1,nrOfframes-1]);
Velocity.velocity2=zeros([1,nrOfframes-1]);
time=t;

for j=1:nrOfframes-1       
    %% Velocity - det blir i enheten pixel/s - måste konvertera om det till m/s
    %subtracting the point on the player with the stationary point
    
    w1=pixelLength(1,j);
    w2=pixelLength(1,j+1);
   
    %if you want to calculate the velocity for the moved points down on the
    %ice. 
    %player1
    x1= abs(Ice.ice(j,1)*w1 - Ice.ice(j+1,1)*w2);
    y1= abs(Ice.ice(j,2)*w1 - Ice.ice(j+1,2)*w2);
    % Global motion
    x2= abs(XValues.xValues6(Point2track.Point2track6,j)*w1 - XValues.xValues6(Point2track.Point2track6,j+1)*w2);
    y2= abs(YValues.yValues6(Point2track.Point2track6,j)*w1 - YValues.yValues6(Point2track.Point2track6,j+1)*w2);
    
    dx=abs(x1-x2);
    dy=abs(y1-y2);
    dz=abs(ZLength.zLength(1,j)-ZLength.zLength(1,j+1));
    Velocity.velocity(1,j)=sqrt(dx.^2 + dy.^2+dz.^2)/t;
    
    %player2
    x3= abs(Ice.ice2(j,1)*w1 - Ice.ice2(j+1,1)*w2);
    y3= abs(Ice.ice2(j,2)*w1 - Ice.ice2(j+1,2)*w2);
    
    dx2=abs(x3-x2);
    dy2=abs(y3-y2);
    dz2=abs(ZLength.zLength2(1,j)-ZLength.zLength2(1,j+1));
    Velocity.velocity2(1,j)=sqrt(dx2.^2 + dy2.^2+dz2.^2)/t;
    %time
    timeaxis(1,j)=time;
    time=time+t;
end
end



