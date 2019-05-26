close all
clear all
clc
% First, insert the correct length of the known object in the function
% "pixellength" (which for now is the height of the rink). 

global objectFrame objectFileReader;

% Read video, insert filename
file = 'ToreyKrugangle2';
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

% Define regions to track (the players, 4 points on the ice and a point
% close to the players to remove the global motion.
[Points] = defineRegion();

% Display the points on the image and return the points the points that are
% valid
[Validity,out,nrOfframes,XValues, YValues] = point(videoPlayer, Points);

%% Create a folder with images of the video
% this since you need to insert some points in some of the images in the
% video sequence.
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
    
%% Decide which points to track on the players and the ice
[Point2track] =point2track(out,Validity,nrOfframes,XValues, YValues);

%% Show chosen and tracked points. Return the pixellength

% Create a new video player to do this. 
ovfr = vision.VideoFileReader(filename);
vp = vision.VideoPlayer('Position', [580 600 700 400]);
of=ovfr();
[Ice,pixelLength]=testpoint2track(YValues,nrOfframes,vp,of,ovfr,Point2track, Points);
release(vp)

%% Run the homography and return the movements of the players on the ice,
% The movements on the ice (in Posmatrix) estimates the movements in the 
% depth of the image ,z direction, seen from the cameras position (Zlength)
close all 
[ZLength,Posmatrix]=homography(w,Ice,Point2track, XValues, YValues,nrOfframes);

%% Velocity
% Calculate velocity (m/s) by the estimated pixellength, movements in x y
% and z direction. the movements in xy direction is decided by the matrices
% XValues and YValues. The dept (z direction) is decided by the movements
% on the ice in Zlength.
[timeaxis,Velocity] = velocity(w,pixelLength,ZLength,Ice, nrOfframes, XValues, YValues, Point2track);
rmdir Movie_Frames s

% Create graph with velocity curves
XX=smooth(Velocity.velocity);
XX2=smooth(Velocity.velocity2);
h=figure;
plot(timeaxis,XX,timeaxis,XX2,'--');
title(sprintf('%s', file));
xlabel('time [s]'); 
ylabel('Velocity [m/s]'); 
legend('player 1','player2');

%% Save positions and graph
attackingplayerxy(:,1)=XValues.xValues(Point2track.Point2track1,:);
attackingplayerxy(:,2)=YValues.yValues(Point2track.Point2track1,:);
injuredplayerxy(:,1)=XValues.xValues7(Point2track.Point2track7,:);
injuredplayerxy(:,2)=YValues.yValues7(Point2track.Point2track7,:);

folder1=convertCharsToStrings(sprintf('%s/XYcoordinatesAttackingPlayer.mat',file));
save(folder1, 'attackingplayerxy')

folder2=convertCharsToStrings(sprintf('%s/XYcoordinatesInjuedPlayer.mat',file));
save(folder2, 'attackingplayerxy')

posmatrix=Posmatrix.posmatrix;
folder4=convertCharsToStrings(sprintf('%s/ZcoordinatesOnIceAttackingPlayer.mat',file));
save(folder4, 'posmatrix')

posmatrix2=Posmatrix.posmatrix2;
folder5=convertCharsToStrings(sprintf('%s//ZcoordinatesOnIceInjuredPlayer.mat',file));
save(folder5, 'posmatrix2')

folder6=convertCharsToStrings(sprintf('%s/VelocityCurve.fig',file));
saveas(h,folder6)

%% Calculate the hit angle 
angle=zeros(nrOfframes,1);
for i=2:nrOfframes
v1=posmatrix(i-1,:)-posmatrix(i,:);
v2=posmatrix2(i-1,:)-posmatrix2(i,:);

a=v1(1,1)*v2(1,1);
b=v1(1,2)*v2(1,2);
c=sqrt((v1(1,1).^2)+(v1(1,2).^2));
d=sqrt((v2(1,1).^2)+(v2(1,2).^2));

angle(i,1)=rad2deg(acos((a+b)/(c*d)));
end

