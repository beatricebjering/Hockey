function [rateOfchange,pixelLength]=pixelsize(nrOfframes)
% Determine the pixel size of each frame throughout the video. This is done by
% defining the pixel length of an object with a know real-world length in
% the first and the last frame. The avarage change is calculated and the
% avarage pixelsize for each frame is determined. 

%% image 1    
% Decide the pixel length of an object in the first frame. 
im=read(imageDatastore('Movie_Frames/1.jpg'));
imshow(im), impixelinfo;
title('choose 2 points, start and end point of the know-length-object');
[x,y]=getpts

array =  [ 
x(1), y(1); 
x(2), y(2);
];

dx=abs(array(1,1)-array(2,1));
dy=abs(array(1,2)-array(2,2));
length1=sqrt(dx.^2 + dy.^2);

%% last image  
% Decide the pixel length of an object in the first frame. 
im=read(imageDatastore(sprintf('Movie_Frames/%d.jpg', nrOfframes)));
imshow(im), impixelinfo;
title('choose 2 points, start and end point of the know-length-object');
[x,y]=getpts

array =  [ 
x(1), y(1); 
x(2), y(2);
];

dx2=abs(array(1,1)-array(2,1));
dy2=abs(array(1,2)-array(2,2));
length2=sqrt(dx2.^2 + dy2.^2);

%% pixellength
% Real length and changes in pixel length
% height of the rink
RealLength=1.21; % in meters --> v�lj en s� lodr�t eller horisontell linje som m�jligt

rateOfchange=(length2-length1)/nrOfframes; %rate of change of pixels per frame
pixelLength=zeros(1,nrOfframes);

for i = 1:nrOfframes
    if i==1 
    pixelLength(1,i)=RealLength/length1; % m/pixel
else
    %should work for both zoom in and out
    length1=length1+rateOfchange;
    pixelLength(1,i)=RealLength/length1; % m/pixel
    end
end
end
