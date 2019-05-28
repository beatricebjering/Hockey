# Hockey
This repository extracts 3D velocities fom a single camera view


The prototype builds on on object tracking with the KLT algorithm and homography. 
The user is asked to define which regions to track by marking thse regions with a square. A region for the attacking and injured player is chosen, as well as regions for tracking four points on the ice to create the homography, and also one point close to the player to extract local motion of the players. The point close to the player should be a stationary point that is not affected by any other movement in the frames (for example the movement of a player). 

Corner points are detected in the defined regions and are followed by the KLT algorithm. The user is asked to chose one of the points, in each defined region, that are tracked throughout the video. Sometimes the frames are too blurry and no point are tracked in one region. in that case the code won't work. The user needs to either change the "MaxBidirectionalError" in the functions "point" and "testpoint2track", or choose another region to follow.

Four points needs to be followed on the ice throughout the video in order to create an homography. The same points that are followed should be denoted in an image of the ice hockey rink, in the same order as they have been denoted in the video. The real size of the ice hockey rink needs to be know and inserted in the function "depth".

The user is also asked to point out a known length object in the function "pixelsize" in order to estimate the length of each pixel and accounting for the zoom effect. The point should be as close to the players as possible.

Velocities is calculated and the angles between the players (seen from above from the ice hockey rink image) is calculated by the positions on the ice hockey rink image.






Estimating velocities by this method can probably be used in other sports as well if the objects that should be followed have visual textures so that they can be tracked by the KLT algorithm. At least four points on the ground needs to be followed and denoted in another image (that represents the ground image, such as the ice hockey rink) to create an homography. 
