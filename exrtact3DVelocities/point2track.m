function [Point2track] =point2track(out,Validity,nrOfframes,XValues, YValues)

% Choose which points to track from the different objects.

%% Object 1 human
figure;
imshow(out);
title('choose which one of the red points to follow (double click)');
[x,y] = getpts();

% Set constants
nrOfmarkers = size(YValues.yValues,1);
Point2track.Point2track1=0;
loop=false;
p=0;
% Find the correct, chosen point with the least square method
for k=1:nrOfmarkers
    if Validity.validity(k,:) == 1
        deltaxx=XValues.xValues(k,nrOfframes)-x(1);
        deltayy=YValues.yValues(k,nrOfframes)-y(1);
        z=sqrt(deltaxx.^2+deltayy.^2);
        if loop==false || z<p
        Point2track.Point2track1=k;
        p=z;
        loop=true;
        end
    end
end
%%  Object 2 human
imshow(out);
title('choose which one of the cyan points to follow (double click)');
[x7,y7] = getpts();
% Set constants
nrOfmarkers7 = size(YValues.yValues7,1);
Point2track.Point2track7=0;
loop7=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers7
    if Validity.validity7(k,:) == 1
        deltaxx=XValues.xValues7(k,nrOfframes)-x7(1);
        deltayy=YValues.yValues7(k,nrOfframes)-y7(1);
        z7=sqrt(deltaxx.^2+deltayy.^2);
        if loop7==false || z7<p
        Point2track.Point2track7=k;
        p=z7;
        loop7=true;
        end
    end
end
%%  Object 6
% Set constants
nrOfmarkers = size(YValues.yValues6,1);
Point2track.Point2track6=0;
loop=false;
p=0;
% Find the point closest to the players automatically (without input)
% with the least square method.
for k=1:nrOfmarkers
    if Validity.validity6(k,:) == 1
        deltaxx=XValues.xValues6(k,nrOfframes)-XValues.xValues(Point2track.Point2track1,nrOfframes);
        deltayy=YValues.yValues6(k,nrOfframes)-YValues.yValues(Point2track.Point2track1,nrOfframes);
        z=sqrt(deltaxx.^2+deltayy.^2);
        if loop==false || z<p
        Point2track.Point2track6=k;
        p=z;
        loop=true;
        end
    end
end

%% Object 2
imshow(out);
title('choose which one of the green points to follow (double click)');
% Set constants
[x2,y2] = getpts();
nrOfmarkers2 = size(YValues.yValues2,1);
Point2track.Point2track2=0;
loop2=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers2
    if Validity.validity2(k,:) == 1
        deltaxx=XValues.xValues2(k,nrOfframes)-x2(1);
        deltayy=YValues.yValues2(k,nrOfframes)-y2(1);
        z2=sqrt(deltaxx.^2+deltayy.^2);
        if loop2==false || z2<p
        Point2track.Point2track2=k;
        p=z2;
        loop2=true;
        end
    end
end
%%  Object 3
imshow(out);
title('choose which one of the black points to follow (double click)');
[x3,y3] = getpts();
% Set constants
nrOfmarkers3 = size(YValues.yValues3,1);
Point2track.Point2track3=0;
loop3=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers3
    if Validity.validity3(k,:) == 1
        deltaxx=XValues.xValues3(k,nrOfframes)-x3(1);
        deltayy=YValues.yValues3(k,nrOfframes)-y3(1);
        z3=sqrt(deltaxx.^2+deltayy.^2);
        if loop3==false || z3<p
        Point2track.Point2track3=k;
        p=z3;
        loop3=true;
        end
    end
end
%%  Object 4
imshow(out);
title('choose which one of the blue points to follow (double click)');
[x4,y4] = getpts();
% Set constants
nrOfmarkers4 = size(YValues.yValues4,1);
Point2track.Point2track4=0;
loop4=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers4
    if Validity.validity4(k,:) == 1
        deltaxx=XValues.xValues4(k,nrOfframes)-x4(1);
        deltayy=YValues.yValues4(k,nrOfframes)-y4(1);
        z4=sqrt(deltaxx.^2+deltayy.^2);
        if loop4==false || z4<p
        Point2track.Point2track4=k;
        p=z4;
        loop4=true;
        end
    end
end
%%  Object 5
imshow(out);
title('choose which one of the yellow points to follow (double click)');
[x5,y5] = getpts();
% Set constants
nrOfmarkers5 = size(YValues.yValues5,1);
Point2track.Point2track5=0;
loop5=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers5
    if Validity.validity5(k,:) == 1
        deltaxx=XValues.xValues5(k,nrOfframes)-x5(1);
        deltayy=YValues.yValues5(k,nrOfframes)-y5(1);
        z5=sqrt(deltaxx.^2+deltayy.^2);
        if loop5==false || z5<p
        Point2track.Point2track5=k;
        p=z5;
        loop5=true;
        end
    end
end
end

