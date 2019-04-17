function [Points] = defineRegion()

global objectFrame;

% Choose two players to follow, first the attacking player, then the 
% attacked/injured player. Choose 4 points on the ice to follow throughout 
% the sequence. Use these four points to make homography in each frame. 
% also use one of them for extracting the subject motion.

% Choose regions of tracking 
figure; 
imshow(objectFrame); 
title('First, define the attacking player');
objectRegion=round(getPosition(imrect));
title('secondly, define the injured player');
objectRegion7=round(getPosition(imrect));
title('thirdly, choose 4 points on the ice');
objectRegion2=round(getPosition(imrect));
objectRegion3=round(getPosition(imrect));
objectRegion4=round(getPosition(imrect));
objectRegion5=round(getPosition(imrect));
title('Lastly, choose a region closest to the point on the object (to remove global motion)');
objectRegion6=round(getPosition(imrect));

objectImage = insertShape(objectFrame,'Rectangle',objectRegion,'Color','red');
objectImage = insertShape(objectImage,'Rectangle',objectRegion7,'Color','cyan');
objectImage = insertShape(objectImage,'Rectangle',objectRegion2,'Color','green');
objectImage = insertShape(objectImage,'Rectangle',objectRegion3,'Color','black');
objectImage = insertShape(objectImage,'Rectangle',objectRegion4,'Color','blue');
objectImage = insertShape(objectImage,'Rectangle',objectRegion5,'Color','yellow');
objectImage = insertShape(objectImage,'Rectangle',objectRegion6,'Color','magenta');


figure;
imshow(objectImage);
title('Boxes shows object regions')

% Creates a number of points in the frame that we are tracking
Points.points = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion);
Points.points2 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion2);
Points.points3 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion3);
Points.points4 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion4);
Points.points5 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion5);
Points.points6 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion6);
Points.points7 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion7);

pointImage = insertMarker(objectFrame,Points.points.Location,'+','Color','red');
pointImage = insertMarker(pointImage,Points.points2.Location,'+','Color','green');
pointImage = insertMarker(pointImage,Points.points3.Location,'+','Color','black');
pointImage = insertMarker(pointImage,Points.points4.Location,'+','Color','blue');
pointImage = insertMarker(pointImage,Points.points5.Location,'+','Color','yellow');
pointImage = insertMarker(pointImage,Points.points6.Location,'+','Color','magenta');
pointImage = insertMarker(pointImage,Points.points7.Location,'+','Color','cyan');

% Show image with points
figure;
imshow(pointImage);
title('Detected interest points');

end

