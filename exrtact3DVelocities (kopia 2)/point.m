function [Validity,out,nrOfframes,XValues, YValues] = point(videoPlayer, Points)
global objectFrame objectFileReader;
close all

% Initialize the trackers
% MaxBidirectionalError is ideally set to 1 but can be higher in order to
% floow the desired regions better
Tracker.tracker1 = vision.PointTracker('MaxBidirectionalError',15);
initialize(Tracker.tracker1,Points.points.Location,objectFrame);
Tracker.tracker2 = vision.PointTracker('MaxBidirectionalError',1);
initialize(Tracker.tracker2,Points.points2.Location,objectFrame);
Tracker.tracker3 = vision.PointTracker('MaxBidirectionalError',1);
initialize(Tracker.tracker3,Points.points3.Location,objectFrame);
Tracker.tracker4 = vision.PointTracker('MaxBidirectionalError',1);
initialize(Tracker.tracker4,Points.points4.Location,objectFrame);
Tracker.tracker5 = vision.PointTracker('MaxBidirectionalError',1);
initialize(Tracker.tracker5,Points.points5.Location,objectFrame);
Tracker.tracker6 = vision.PointTracker('MaxBidirectionalError',1);
initialize(Tracker.tracker6,Points.points6.Location,objectFrame);
Tracker.tracker7 = vision.PointTracker('MaxBidirectionalError',15);
initialize(Tracker.tracker7,Points.points7.Location,objectFrame);

i=1;
nrOfframes =0;

% Track the points in each frame
while ~isDone(objectFileReader)
      frame = objectFileReader();
      nrOfframes = nrOfframes +1;
      
      % p gives an array of x- and y-values of the points. Validity shows 
      % if the values of the points are valid or not. If they aren't valid 
      % they fall out. 
      
      %% Object1 human
      [p,Validity.validity] = Tracker.tracker1(frame);
      out = insertMarker(frame,p(Validity.validity, :),'+','Color','red');
      
      % Save the xy coordinates in array for player object 1
      XValues.xValues(:,i)=p(:,1);
      YValues.yValues(:,i)=p(:,2);
      
      %% Object2 human
      [p7,Validity.validity7] = Tracker.tracker7(frame);
      % Insert the points in "out" image
      out = insertMarker(out,p7(Validity.validity7, :),'+','Color','cyan');
      
      % Save the xy coordinates in array for player object 2
      XValues.xValues7(:,i)=p7(:,1);
      YValues.yValues7(:,i)=p7(:,2);   
      %% Object2
      [p2,Validity.validity2] = Tracker.tracker2(frame);
      out = insertMarker(out,p2(Validity.validity2, :),'+','Color','green');
      
      % Save the xy coordinates in array for point 1
      XValues.xValues2(:,i)=p2(:,1);
      YValues.yValues2(:,i)=p2(:,2);
      %% Object3
      [p3,Validity.validity3] = Tracker.tracker3(frame);
      out = insertMarker(out,p3(Validity.validity3, :),'+','Color','black');
      
      % Save the xy coordinates in array for point 2
      XValues.xValues3(:,i)=p3(:,1);
      YValues.yValues3(:,i)=p3(:,2);
      %% Object 4
      [p4,Validity.validity4] = Tracker.tracker4(frame);
      out = insertMarker(out,p4(Validity.validity4, :),'+','Color','blue');
      
      % Save the xy coordinates in array for point 3
      XValues.xValues4(:,i)=p4(:,1);
      YValues.yValues4(:,i)=p4(:,2);
      %% Object 5
      [p5,Validity.validity5] = Tracker.tracker5(frame);
      out = insertMarker(out,p5(Validity.validity5, :),'+','Color','yellow');
      
      % Save the xy coordinates in array for point 4
      XValues.xValues5(:,i)=p5(:,1);
      YValues.yValues5(:,i)=p5(:,2);
       %% Object 6
      [p6,Validity.validity6] = Tracker.tracker6(frame);
      out = insertMarker(out,p6(Validity.validity6, :),'+','Color','magenta');
      
      % Save the xy coordinates in array for the point to extract the
      % global motion
      XValues.xValues6(:,i)=p6(:,1);
      YValues.yValues6(:,i)=p6(:,2);
      %% Show video
      i=i+1;     
      videoPlayer(out)
end
end

