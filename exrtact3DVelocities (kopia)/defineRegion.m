function [points,points2,points3,points4 ,points5,points6,points7] = defineRegion()

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
points = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion);
points2 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion2);
points3 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion3);
points4 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion4);
points5 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion5);
points6 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion6);
points7 = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion7);

pointImage = insertMarker(objectFrame,points.Location,'+','Color','red');
pointImage = insertMarker(pointImage,points2.Location,'+','Color','green');
pointImage = insertMarker(pointImage,points3.Location,'+','Color','black');
pointImage = insertMarker(pointImage,points4.Location,'+','Color','blue');
pointImage = insertMarker(pointImage,points5.Location,'+','Color','yellow');
pointImage = insertMarker(pointImage,points6.Location,'+','Color','magenta');
pointImage = insertMarker(pointImage,points7.Location,'+','Color','cyan');

% Show image with points
figure;
imshow(pointImage);
title('Detected interest points');

end

