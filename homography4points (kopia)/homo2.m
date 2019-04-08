
clear all
close all
%{
v = VideoReader('malkin.mp4');
videof1 = read(v,1);
videof2 = read(v,9);

% Take the first and last frame in the sequence
imwrite(videof1,['frame1' , '.jpg']);
imwrite(videof2,['frameinf', '.jpg']);
 %}
Iin1 = imread('im1.png');
Iin2 = imread('frameinf.jpg');
im1f=figure; imshow(Iin1,[]), impixelinfo;
im2f=figure; imshow(Iin2,[]), impixelinfo;
%% location of points in images
% Location of control points in (x,y) input image coords (pixels)
% These are the corners 
figure(im1f), [x1,y1]=getpts
Pimg1 = [
x1(1), y1(1);
x1(2), y1(2);
x1(3), y1(3);
x1(4), y1(4);
];

% Define location of control points in the world. '
im3f = imread('im2.jpg');
imwf=figure; imshow(im3f,[]), impixelinfo;
figure(imwf), [x2,y2]=getpts

Pworld1 =  [ 
x2(1), y2(1); 
x2(2), y2(2);
x2(3), y2(3);
x2(4), y2(4);
];

iptsetpref('ImshowAxesVisible','on')
imshow(Iin1)

%% Homograpical transform
% Compute transform, from corresponding control points. create a geometric
% transformation of the hockey image to fit the rink image
Tform1 = fitgeotrans(Pimg1,Pworld1,'projective');

% Transform input image to output image
Iout1 = imwarp(Iin1,Tform1,'FillValues', 255);
figure, imshow(Iout1);

% blend rink image and transformed image
Rfixed = imref2d(size(im3f));
registered1 = imwarp(Iin1,Tform1,'FillValues', 255,'OutputView',Rfixed);
%I3=imshowpair(im3f,registered1,'blend');
I3=imfuse(im3f,registered1,'blend');
imshow(I3), imwrite(I3, 'firstimagebland.jpg');


% convert the pixels to length in cm.
% [xx,yy]=size(Iin2);
% xpixInCm=xx/609.6;
% ypixInCm=yy/259;
% x2=xpixInCm*x2;
% y2=ypixInCm*y2;

% choose 1 or 2 points to follow on the moving obejct(s). 
% choose 4 points on the ice to follow throughout the sequence
% use these four points to make homography in each frame. also use one of 
% them for extracting the subject motion.

