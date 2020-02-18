#!/bin/bash

#Launch 1 terminal and send the stream
cd ros_to_rtsp_ws
source devel/setup.bash

vlc --no-audio --avcodec-hw=any --sout-rtp-proto=udp --network-caching=300 --sout-udp-caching=0 --clock-jitter=0 --rtp-max-misorder=0 rtsp://0.0.0.0:8554/front :udp-timeout=0 enable-max-performance=1