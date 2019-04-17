%% Play a Video File
% Read video from a file and set up player object. 

videoFReader = vision.VideoFileReader('backes.mp4');
videoPlayer = vision.VideoPlayer('Position', [580 600 700 400]);
%% 
% Play video. Every call to the |step| method reads another frame.
%%
while ~isDone(videoFReader)
   frame = step(videoFReader);
   step(videoPlayer,frame);
end
%% 
% Close the file reader and video player.
%%
release(videoFReader);
release(videoPlayer);

%% 
% Copyright 2012 The MathWorks, Inc.