close all
clear all
clc
% Insert the correct length of the known object in the function
% "pixellength" (which for now is the height of the rink).

global objectFrame objectFileReader;

% Read video
file = 'torresangle2';
filename=sprintf('videos/%s.mp4', file);
objectFileReader = vision.VideoFileReader(filename);
objectFrame = objectFileReader('Position', [580 600 1000 700]);
w = VideoReader(filename);
videoPlayer = vision.VideoPlayer('Position', [580 600 1000 700]);

% Create folder to save data from video
OutDataDir = sprintf('%s', file);
if ~exist(OutDataDir, 'dir')
    mkdir(OutDataDir)
end

% Define regions to track
[points,points2,points3,points4,points5,points6,points7] = defineRegion();

% Display the points on the image
[validity, validity2, validity3, validity4, validity5,validity6, validity7,out,nrOfframes,xValues, yValues, xValues2, yValues2, xValues3, yValues3, xValues4, yValues4, xValues5, yValues5,xValues6, yValues6,xValues7, yValues7] = point(videoPlayer, points, points2, points3, points4, points5,points6,points7);
%% Create a folder with images of the video
 OutVideoDir = sprintf('Movie_Frames');
 
 % Create the folder if it doesn't exist already.
if ~exist(OutVideoDir, 'dir')
    mkdir Movie_Frames;
end
    for i = 1:nrOfframes
        img = read(w,i);
        baseFileName = sprintf('%d.jpg', i); % e.g. "1.jpg"
        
        fullFileName = fullfile(OutVideoDir, baseFileName); 
        imwrite(img, fullFileName);
    end
%% Decide which points to track
[Point2track1, Point2track2, Point2track3, Point2track4, Point2track5,Point2track6,Point2track7] =point2track(out,validity, validity2, validity3, validity4, validity5,validity6,validity7,nrOfframes,xValues, yValues, xValues2, yValues2, xValues3, yValues3, xValues4, yValues4, xValues5, yValues5,xValues6, yValues6,xValues7, yValues7);
%% Show tracked points
ovfr = vision.VideoFileReader(filename);
vp = vision.VideoPlayer('Position', [580 600 700 400]);
of=ovfr();
[ice,ice2,pixelLength]=testpoint2track(yValues6,yValues, yValues7,nrOfframes,vp,of,ovfr,Point2track1,Point2track2, Point2track3, Point2track4, Point2track5,Point2track6,Point2track7, points, points2, points3, points4, points5,points6,points7);
release(vp)

%% Run the homography
close all 
[zLength,zLength2,posmatrix,posmatrix2]=homography(w,ice,ice2, Point2track1, Point2track2, Point2track3, Point2track4, Point2track5, Point2track7, xValues, yValues, xValues2, yValues2, xValues3, yValues3, xValues4, yValues4, xValues5, yValues5,xValues7, yValues7,nrOfframes);

%% Velocity
% determine the avarage pixelsize and the change of the pixel size from
% image 1 to the last image.
% Calculate velocity (for now pixels/s). The framerate must be known.

[timeaxis,velocity,velocity2] = velocity(pixelLength,zLength,zLength2,ice,ice2, nrOfframes, xValues6, yValues6,xValues7, yValues7, Point2track6,Point2track7);
rmdir Movie_Frames s

% Create graph
XX=smoothdata(velocity);
XX2=smoothdata(velocity2);
h=figure;
plot(timeaxis,XX,timeaxis,XX2,'--');
title(sprintf('%s', file));
xlabel('time [s]'); 
ylabel('Velocity [m/s]'); 
legend('player 1','player2');

%% Save positions and graph
attackingplayerxy(:,1)=xValues(Point2track1,:);
attackingplayerxy(:,2)=yValues(Point2track1,:);
injuredplayerxy(:,1)=xValues7(Point2track7,:);
injuredplayerxy(:,2)=yValues7(Point2track7,:);

folder1=convertCharsToStrings(sprintf('%s/XYcoordinatesAttackingPlayer.mat',file));
save(folder1, 'attackingplayerxy')

folder2=convertCharsToStrings(sprintf('%s/XYcoordinatesInjuedPlayer.mat',file));
save(folder2, 'attackingplayerxy')

folder3=convertCharsToStrings(sprintf('%s/ZcoordinatesOnIceAttackingPlayer.mat',file));
save(folder3, 'ice')

folder4=convertCharsToStrings(sprintf('%s/ZcoordinatesOnIceAttackingPlayer.mat',file));
save(folder4, 'posmatrix')

folder5=convertCharsToStrings(sprintf('%s//ZcoordinatesOnIceInjuredPlayer.mat',file));
save(folder5, 'posmatrix2')

folder6=convertCharsToStrings(sprintf('%s/VelocityCurve.fig',file));
saveas(h,folder6)
