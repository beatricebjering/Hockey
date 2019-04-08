function [validity, validity2, validity3, validity4, validity5,validity6, validity7,out,nrOfframes,xValues, yValues, xValues2, yValues2, xValues3, yValues3, xValues4, yValues4, xValues5, yValues5,xValues6, yValues6,xValues7, yValues7] = point(videoPlayer, points, points2, points3, points4, points5,points6,points7)
global objectFrame objectFileReader;
close all

% Initialize the trackers
% MaxBidirectionalError is ideally set to 1 but can be higher in order to
% floow the desired regions better
tracker1 = vision.PointTracker('MaxBidirectionalError',3);
initialize(tracker1,points.Location,objectFrame);
tracker2 = vision.PointTracker('MaxBidirectionalError',3);
initialize(tracker2,points2.Location,objectFrame);
tracker3 = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker3,points3.Location,objectFrame);
tracker4 = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker4,points4.Location,objectFrame);
tracker5 = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker5,points5.Location,objectFrame);
tracker6 = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker6,points6.Location,objectFrame);
tracker7 = vision.PointTracker('MaxBidirectionalError',3);
initialize(tracker7,points7.Location,objectFrame);

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
      [p,validity] = tracker1(frame);
      out = insertMarker(frame,p(validity, :),'+','Color','red');
      
      % Save the xy coordinates in array for player object 1
      xValues(:,i)=p(:,1);
      yValues(:,i)=p(:,2);
      
      %% Object2 human
      [p7,validity7] = tracker7(frame);
      % Insert the points in "out" image
      out = insertMarker(out,p7(validity7, :),'+','Color','cyan');
      
      % Save the xy coordinates in array for player object 2
      xValues7(:,i)=p7(:,1);
      yValues7(:,i)=p7(:,2);   
      %% Object2
      [p2,validity2] = tracker2(frame);
      out = insertMarker(out,p2(validity2, :),'+','Color','green');
      
      % Save the xy coordinates in array for point 1
      xValues2(:,i)=p2(:,1);
      yValues2(:,i)=p2(:,2);
      %% Object3
      [p3,validity3] = tracker3(frame);
      out = insertMarker(out,p3(validity3, :),'+','Color','black');
      
      % Save the xy coordinates in array for point 2
      xValues3(:,i)=p3(:,1);
      yValues3(:,i)=p3(:,2);
      %% Object 4
      [p4,validity4] = tracker4(frame);
      out = insertMarker(out,p4(validity4, :),'+','Color','blue');
      
      % Save the xy coordinates in array for point 3
      xValues4(:,i)=p4(:,1);
      yValues4(:,i)=p4(:,2);
      %% Object 5
      [p5,validity5] = tracker5(frame);
      out = insertMarker(out,p5(validity5, :),'+','Color','yellow');
      
      % Save the xy coordinates in array for point 4
      xValues5(:,i)=p5(:,1);
      yValues5(:,i)=p5(:,2);
       %% Object 6
      [p6,validity6] = tracker6(frame);
      out = insertMarker(out,p6(validity6, :),'+','Color','magenta');
      
      % Save the xy coordinates in array for the point to extract the
      % global motion
      xValues6(:,i)=p6(:,1);
      yValues6(:,i)=p6(:,2);
      %% Show video
      i=i+1;     
      videoPlayer(out)
end
end

