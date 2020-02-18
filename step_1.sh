#!/bin/bash

#Launch 1 terminal and send the stream
cd ros_to_rtsp_ws
source devel/setup.bash

# Launch the file that starts the stream
roslaunch ros_rtsp rtsp_streams.launch

