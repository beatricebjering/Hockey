function [timeaxis,velocity,velocity2] = velocity(pixelLength,zLength,zLength2,ice,ice2, nrOfframes, xValues6, yValues6,xValues7, yValues7, Point2track6,Point2track7)
frameRate=29;
t=1/frameRate; %tiden för hela videon
timeaxis=zeros([1,nrOfframes-1]);
velocity=zeros([1,nrOfframes-1]);
velocity2=zeros([1,nrOfframes-1]);
time=t;

for j=1:nrOfframes-1       
    %% Velocity - det blir i enheten pixel/s - måste konvertera om det till m/s
    %subtracting the point on the player with the stationary point
    
    w1=pixelLength(1,j);
    w2=pixelLength(1,j+1);
   
    %if you want to calculate the velocity for the moved points down on the
    %ice. 
    %player1
    x1= abs(ice(j,1)*w1 - ice(j+1,1)*w2);
    y1= abs(ice(j,2)*w1 - ice(j+1,2)*w2);
    % Global motion
    x2= abs(xValues6(Point2track6,j)*w1 - xValues6(Point2track6,j+1)*w2);
    y2= abs(yValues6(Point2track6,j)*w1 - yValues6(Point2track6,j+1)*w2);
    
    dx=abs(x1-x2);
    dy=abs(y1-y2);
    dz=abs(zLength(1,j)-zLength(1,j+1));
    velocity(1,j)=sqrt(dx.^2 + dy.^2+dz.^2)/t;
    
    %player2
    x3= abs(ice2(j,1)*w1 - ice2(j+1,1)*w2);
    y3= abs(ice2(j,2)*w1 - ice2(j+1,2)*w2);
    
    dx2=abs(x3-x2);
    dy2=abs(y3-y2);
    dz2=abs(zLength2(1,j)-zLength2(1,j+1));
    velocity2(1,j)=sqrt(dx2.^2 + dy2.^2+dz2.^2)/t;
    %time
    timeaxis(1,j)=time;
    time=time+t;
end
end



