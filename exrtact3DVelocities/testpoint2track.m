
function [Ice,pixelLength]=testpoint2track(YValues,nrOfframes,vp,of,ovfr,Point2track, Points)
close all

%% Initialize the trackers to see the chosen points in the frames
% MaxBidirectionalError is ideally set to 1 but can be higher in order to
% follow the desired regions better. Ideally the error is set to a number
% between 1-3. This error should be set to the same values in the function
% "point".
tracker1x = vision.PointTracker('MaxBidirectionalError',3);
initialize(tracker1x,Points.points.Location,of);
tracker2x = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker2x,Points.points2.Location,of);
tracker3x = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker3x,Points.points3.Location,of);
tracker4x = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker4x,Points.points4.Location,of);
tracker5x = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker5x,Points.points5.Location,of);
tracker6x = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker6x,Points.points6.Location,of);
tracker7x = vision.PointTracker('MaxBidirectionalError',3);
initialize(tracker7x,Points.points7.Location,of);

% Set constants and matrices
framesnr =0;
Ice.ice=zeros(nrOfframes,2);
Ice.ice2=zeros(nrOfframes,2);
corrHeight1=0;
corrHeight2=0;

%% Determine the pixel size 
% Determine the pixelsize in each frame throughout the video with 
% the function pixelsize.
[rateOfchange,pixelLength]=pixelsize(nrOfframes);
rateOfchange=1+rateOfchange;

while ~isDone(ovfr)
      frame = ovfr();
      framesnr = framesnr +1;
      % The points gives an array of x- and y-values of the points. If the
      % points aren't valied they fall out. 

      
      %% Object1 and 2: the players
      [pointsx,~] = tracker1x(frame);
      % Insert the marker for the attacking player in the frames
      out2 = insertMarker(frame,pointsx(Point2track.Point2track1, :),'+','Color','red');
      
      [pointsx7,~] = tracker7x(frame);
      % Insert the marker for the injured player in the frames
      out2 = insertMarker(out2,pointsx7(Point2track.Point2track7, :),'+','Color','yellow'); 
      
      
      % Insert markers on the ice below the chosen tracked point on the
      % players to correctly project the points on the ice in the
      % homography.
      Ice.ice(framesnr,:)=pointsx(Point2track.Point2track1, :);
      Ice.ice2(framesnr,:)=pointsx7(Point2track.Point2track7, :);
      if framesnr==1
          imshow(out2,[])
          title('put out point on the ice below the red marker (double click)')
          [~,yice]=getpts;
          title('put out point on the ice below the yellow marker (double click)')
          [~,y2ice]=getpts;
          lengthOnIce=abs(Ice.ice(framesnr,2)-yice);
          lengthOnIce2=abs(Ice.ice2(framesnr,2)-y2ice);
      end
      
      %% Object2
      [pointsx2,~] = tracker2x(frame);
      % Insert the points on the ice in the"out" image
      out2 = insertMarker(out2,pointsx2(Point2track.Point2track2, :),'+','Color','green'); 
      %% Object3
      [pointsx3,~] = tracker3x(frame);
      % Insert the points on the ice in the "out" image
      out2 = insertMarker(out2,pointsx3(Point2track.Point2track3, :),'+','Color','black'); 
      %% Object4
      [pointsx4,~] = tracker4x(frame);
      % Insert the points on the ice in the "out" image
      out2 = insertMarker(out2,pointsx4(Point2track.Point2track4, :),'+','Color','blue'); 
      %% Object5
      [pointsx5,~] = tracker5x(frame);
      % Insert the points on the ice in the "out" image
      out2 = insertMarker(out2,pointsx5(Point2track.Point2track5, :),'+','Color','yellow'); 
      %% Object2 6
      [pointsx6,~] = tracker6x(frame);
      % Insert the points on the ice in the "out" image
      out2 = insertMarker(out2,pointsx6(Point2track.Point2track6, :),'+','Color','magenta'); 
      
      %% Insert the opints correctly on the ice 
      % A thing that needs to be taken into consideration is that the player might
      % be jumping or change the position of the body part up in the air.
      % This needs to be taken into consideration, otherwise the point on
      % the ice will not be projected correctly. This is depending on the
      % zoom as well. Correction of this is is described below. 
      if framesnr>1
          
          changeGlobalMotiony=abs(YValues.yValues6(Point2track.Point2track6,framesnr)-YValues.yValues6(Point2track.Point2track6,framesnr-1));
          changeypoint1=YValues.yValues(Point2track.Point2track1,framesnr-1)-YValues.yValues(Point2track.Point2track1,framesnr);
          changeypoint7=YValues.yValues7(Point2track.Point2track7,framesnr-1)-YValues.yValues7(Point2track.Point2track7,framesnr)+changeGlobalMotiony;
          
          
          if changeypoint1>=0 && changeGlobalMotiony<=0
              corrHeight1=(changeypoint1+changeGlobalMotiony)*rateOfchange;
          elseif changeypoint1<=0 && changeGlobalMotiony>=0
              corrHeight1=(changeypoint1+changeGlobalMotiony)*rateOfchange;
          elseif changeypoint1>=0 && changeGlobalMotiony>=0
              corrHeight1=abs(changeypoint1-changeGlobalMotiony)*rateOfchange;
          elseif changeypoint1<=0 && changeGlobalMotiony<=0
              corrHeight1=abs(changeypoint1-changeGlobalMotiony)*rateOfchange;
          end
          
          if changeypoint7>=0 && changeGlobalMotiony<=0
              corrHeight2=(changeypoint7+changeGlobalMotiony)*rateOfchange;
          elseif changeypoint7<=0 && changeGlobalMotiony>=0
              corrHeight2=(changeypoint7+changeGlobalMotiony)*rateOfchange;
          elseif changeypoint7>=0 && changeGlobalMotiony>=0
              corrHeight2=abs(changeypoint7-changeGlobalMotiony)*rateOfchange;
          elseif changeypoint7<=0 && changeGlobalMotiony<=0
              corrHeight2=abs(changeypoint7-changeGlobalMotiony)*rateOfchange;
          end

      end
      
      Ice.ice(framesnr,2)=Ice.ice(framesnr,2)+lengthOnIce+corrHeight1;
      out2 = insertMarker(out2,Ice.ice,'+','Color','cyan');
      
      Ice.ice2(framesnr,2)=Ice.ice2(framesnr,2)+lengthOnIce2+corrHeight2;
      out2 = insertMarker(out2,Ice.ice2,'+','Color','green');
      
      % Show the frames with inserted points
      vp(out2);
end
end

