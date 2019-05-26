function [ZLength,Posmatrix]=homography(w,Ice,Point2track, XValues, YValues,nrOfframes)
% In this  function the homography will be created by choosing 4 points on
% the ice to follow throughput the sequence. The frames will be projected 
% on the ice and the chosen points on the players are projected on the ice 
% and seen on the homography. Further down the depth movement of the
% players is calculated in the subfunction "depth".


%% Choose 4 points on the ice to follow throughout the sequence, 
% and use these four points to make homography in each frame.

% Set constants
Posmatrix.posmatrix=zeros(nrOfframes,2);
Posmatrix.posmatrix2=zeros(nrOfframes,2);

% Define location of control points (world points) on the rink 
im3f = imread('im2.jpg');
imwf=figure; title('put out 4 world points (click, click, click, doubleclick)'), imshow(im3f,[]), impixelinfo;
figure(imwf), [x2,y2]=getpts

Pworld1 =  [ 
x2(1), y2(1); 
x2(2), y2(2);
x2(3), y2(3);
x2(4), y2(4);
];

%% Calculate the homography for all images. 

% Extract x and y coordinates for each point chosen on the ice (from the 
% ice hockey image) from the function "point2track", saved in the Structs
% XValues and YValues.
for i=1:nrOfframes
    Pimg1 = [
    XValues.xValues2(Point2track.Point2track2,i), YValues.yValues2(Point2track.Point2track2,i);
    XValues.xValues3(Point2track.Point2track3,i), YValues.yValues3(Point2track.Point2track3,i);
    XValues.xValues4(Point2track.Point2track4,i), YValues.yValues4(Point2track.Point2track4,i);
    XValues.xValues5(Point2track.Point2track5,i), YValues.yValues5(Point2track.Point2track5,i);
    ];

% Project the ice hockey image on the rink
Tform1 = fitgeotrans(Pimg1,Pworld1,'projective');


% Show the mocement of the player in the rink
objx2=Ice.ice(i,1); 
objy2=Ice.ice(i,2);
[h n] = transformPointsForward(Tform1,objx2,objy2);
p=[h n];
objx4=Ice.ice2(i,1); 
objy4=Ice.ice2(i,2);
[h2 n2] = transformPointsForward(Tform1,objx4,objy4);
p2=[h2 n2];

% Save the position on the ice in a matrix to use when calculate depth
% later on.
Posmatrix.posmatrix(i,:)=[h n];
Posmatrix.posmatrix2(i,:)=[h2 n2];

% Insert the position of the object in the rink
im3f = insertMarker(im3f,p,'o','color', 'red');
im3f = insertMarker(im3f,p2,'o','color', 'red');

% Insert the center of rotation of the image/camera, (this is used in the
% subfuction depth later on)
if i==nrOfframes
[cx cy] = transformPointsForward(Tform1,w.Width/2,w.Height);
p3=[cx cy];
im3f = insertMarker(im3f,p3,'o','color', 'black');
end

% Show projection
Iin1= imread(sprintf('Movie_Frames/%d.jpg', i));
Rfixed = imref2d(size(im3f));
registered1 = imwarp(Iin1,Tform1,'FillValues', 255,'OutputView',Rfixed);
I3=imfuse(im3f,registered1,'blend');
imshow(I3), imwrite(I3, 'firstimagebland.jpg');

end
close all 
imshow(I3)

% Estimate the depth movemetn (z direction)
[ZLength]=depth(I3,Posmatrix,nrOfframes,p3);
end






