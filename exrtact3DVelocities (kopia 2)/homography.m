function [ZLength,Posmatrix]=homography(w,Ice,Point2track, XValues, YValues,nrOfframes)
% choose 1 or 2 points to follow on the moving obejct(s). 
% choose 4 points on the ice to follow throughout the sequence
% use these four points to make homography in each frame. also use one of 
% them for extracting the subject motion.

% Define location of control points in the ice hockey rink, world points
im3f = imread('im2.jpg');
imwf=figure; title('put out 4 world points'), imshow(im3f,[]), impixelinfo;
figure(imwf), [x2,y2]=getpts
Posmatrix.posmatrix=zeros(nrOfframes,2);
Posmatrix.posmatrix2=zeros(nrOfframes,2);

Pworld1 =  [ 
x2(1), y2(1); 
x2(2), y2(2);
x2(3), y2(3);
x2(4), y2(4);
];

%calculate the homography for all images. Later go through all the images
%with the nrOfFrames
% i want to have the points in the first image, the coorinates for the
% points i've chosen to track. I want to take out the points i've chosen to
% track in each and every frame. 

for i=1:nrOfframes
    Pimg1 = [
    XValues.xValues2(Point2track.Point2track2,i), YValues.yValues2(Point2track.Point2track2,i);
    XValues.xValues3(Point2track.Point2track3,i), YValues.yValues3(Point2track.Point2track3,i);
    XValues.xValues4(Point2track.Point2track4,i), YValues.yValues4(Point2track.Point2track4,i);
    XValues.xValues5(Point2track.Point2track5,i), YValues.yValues5(Point2track.Point2track5,i);
    ];

%project the ice hockey image on the rink

Tform1 = fitgeotrans(Pimg1,Pworld1,'projective');

%insert the movement of the player1 in the rink
objx=XValues.xValues(Point2track.Point2track1,i); 
objy=YValues.yValues(Point2track.Point2track1,i);
[u v] = transformPointsForward(Tform1,objx,objy);
position=[u v];

%insert the movement of the player2 in the rink
objx3=XValues.xValues7(Point2track.Point2track7,i); 
objy3=YValues.yValues7(Point2track.Point2track7,i);
[u2 v2] = transformPointsForward(Tform1,objx3,objy3);
position2=[u2 v2];

%insert the position of the object in the rink
im3f = insertMarker(im3f,position,'o','color', 'black');
im3f = insertMarker(im3f,position2,'o','color', 'green');

%show the mocement of the player in the rink when the coordinates is moved
%down on the ice (if we are following e.g the head).
objx2=Ice.ice(i,1); 
objy2=Ice.ice(i,2);
[h n] = transformPointsForward(Tform1,objx2,objy2);
p=[h n];
objx4=Ice.ice2(i,1); 
objy4=Ice.ice2(i,2);
[h2 n2] = transformPointsForward(Tform1,objx4,objy4);
p2=[h2 n2];

% save the position on the ice in a matrix to use when calculate depth
% later on.
Posmatrix.posmatrix(i,:)=[h n];
Posmatrix.posmatrix2(i,:)=[h2 n2];

%insert the position of the object in the rink
im3f = insertMarker(im3f,p,'o','color', 'red');
im3f = insertMarker(im3f,p2,'o','color', 'red');

%insert the center of rotation of the image/camera
if i==nrOfframes
[cx cy] = transformPointsForward(Tform1,w.Width/2,w.Height);
p3=[cx cy];
im3f = insertMarker(im3f,p3,'o','color', 'black');
end

%show projection
Iin1= imread(sprintf('Movie_Frames/%d.jpg', i));
Rfixed = imref2d(size(im3f));
registered1 = imwarp(Iin1,Tform1,'FillValues', 255,'OutputView',Rfixed);
I3=imfuse(im3f,registered1,'blend');
imshow(I3), imwrite(I3, 'firstimagebland.jpg');

end
close all 
imshow(I3)
[ZLength]=depth(I3,Posmatrix,nrOfframes,p3);
end






