close all
clear all
clc
% Insert the correct length of the known object in the function
% "pixellength" (which for now is the height of the rink). 

global objectFrame objectFileReader;

% Read video
file = 'try9&10';
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
[Points] = defineRegion();

% Display the points on the image
%SKRIV STRUCTAR
%skriv vad de har in för något och och reutnerar för något.
[Validity,out,nrOfframes,XValues, YValues] = point(videoPlayer, Points);
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
[Point2track] =point2track(out,Validity,nrOfframes,XValues, YValues);
%% Show tracked points
ovfr = vision.VideoFileReader(filename);
vp = vision.VideoPlayer('Position', [580 600 700 400]);
of=ovfr();
[Ice,pixelLength]=testpoint2track(YValues,nrOfframes,vp,of,ovfr,Point2track, Points);
release(vp)

%% Run the homography
close all 
[ZLength,Posmatrix]=homography(w,Ice,Point2track, XValues, YValues,nrOfframes);

%% Velocity
% determine the avarage pixelsize and the change of the pixel size from
% image 1 to the last image.
% Calculate velocity (for now pixels/s). The framerate must be known.

[timeaxis,Velocity] = velocity(w,pixelLength,ZLength,Ice, nrOfframes, XValues, YValues, Point2track);
rmdir Movie_Frames s

% Create graph
XX=smoothdata(Velocity.velocity);
XX2=smoothdata(Velocity.velocity2);
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
