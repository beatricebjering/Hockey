function [Point2track1, Point2track2, Point2track3, Point2track4, Point2track5,Point2track6,Point2track7] =point2track(out,validity, validity2, validity3, validity4, validity5,validity6,validity7,nrOfframes,xValues, yValues, xValues2, yValues2, xValues3, yValues3, xValues4, yValues4, xValues5, yValues5,xValues6, yValues6,xValues7, yValues7)

% Choose which points to track from the different objects.

%% Object 1 human
figure;
imshow(out);
title('choose which one of the red points to follow');
[x,y] = getpts();
nrOfmarkers = size(yValues,1);
Point2track1=0;
loop=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers
    if validity(k,:) == 1
        deltaxx=xValues(k,nrOfframes)-x(1);
        deltayy=yValues(k,nrOfframes)-y(1);
        z=sqrt(deltaxx.^2+deltayy.^2);
        if loop==false || z<p
        Point2track1=k;
        p=z;
        loop=true;
        end
    end
end
%%  Object 2 human
imshow(out);
title('choose which one of the cyan points to follow');
[x7,y7] = getpts();
nrOfmarkers7 = size(yValues7,1);
Point2track7=0;
loop7=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers7
    if validity7(k,:) == 1
        deltaxx=xValues7(k,nrOfframes)-x7(1);
        deltayy=yValues7(k,nrOfframes)-y7(1);
        z7=sqrt(deltaxx.^2+deltayy.^2);
        if loop7==false || z7<p
        Point2track7=k;
        p=z7;
        loop7=true;
        end
    end
end
%%  Object 6
nrOfmarkers = size(yValues6,1);
Point2track6=0;
loop=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers
    if validity6(k,:) == 1
        deltaxx=xValues6(k,nrOfframes)-xValues(Point2track1,nrOfframes);
        deltayy=yValues6(k,nrOfframes)-yValues(Point2track1,nrOfframes);
        z=sqrt(deltaxx.^2+deltayy.^2);
        if loop==false || z<p
        Point2track6=k;
        p=z;
        loop=true;
        end
    end
end

%% Object 2
imshow(out);
title('choose which one of the green points to follow');
[x2,y2] = getpts();
nrOfmarkers2 = size(yValues2,1);
Point2track2=0;
loop2=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers2
    if validity2(k,:) == 1
        deltaxx=xValues2(k,nrOfframes)-x2(1);
        deltayy=yValues2(k,nrOfframes)-y2(1);
        z2=sqrt(deltaxx.^2+deltayy.^2);
        if loop2==false || z2<p
        Point2track2=k;
        p=z2;
        loop2=true;
        end
    end
end
%%  Object 3
imshow(out);
title('choose which one of the black points to follow');
[x3,y3] = getpts();
nrOfmarkers3 = size(yValues3,1);
Point2track3=0;
loop3=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers3
    if validity3(k,:) == 1
        deltaxx=xValues3(k,nrOfframes)-x3(1);
        deltayy=yValues3(k,nrOfframes)-y3(1);
        z3=sqrt(deltaxx.^2+deltayy.^2);
        if loop3==false || z3<p
        Point2track3=k;
        p=z3;
        loop3=true;
        end
    end
end
%%  Object 4
imshow(out);
title('choose which one of the blue points to follow');
[x4,y4] = getpts();
nrOfmarkers4 = size(yValues4,1);
Point2track4=0;
loop4=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers4
    if validity4(k,:) == 1
        deltaxx=xValues4(k,nrOfframes)-x4(1);
        deltayy=yValues4(k,nrOfframes)-y4(1);
        z4=sqrt(deltaxx.^2+deltayy.^2);
        if loop4==false || z4<p
        Point2track4=k;
        p=z4;
        loop4=true;
        end
    end
end
%%  Object 5
imshow(out);
title('choose which one of the yellow points to follow');
[x5,y5] = getpts();
nrOfmarkers5 = size(yValues5,1);
Point2track5=0;
loop5=false;
p=0;
% Find the correct point with the least square method
for k=1:nrOfmarkers5
    if validity5(k,:) == 1
        deltaxx=xValues5(k,nrOfframes)-x5(1);
        deltayy=yValues5(k,nrOfframes)-y5(1);
        z5=sqrt(deltaxx.^2+deltayy.^2);
        if loop5==false || z5<p
        Point2track5=k;
        p=z5;
        loop5=true;
        end
    end
end
end

