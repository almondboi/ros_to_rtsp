# ros_to_rtsp

This allows user to publish a ROS Video Stream as a topic and subscribe to it using VLC.
Use of RTSP to obtain the video feed.

Tested on Ubuntu 16.04 LTS with ROS Kinetic.


# Installation and Dependencies

ROS
gstreamer libraries

Needed libraries are inside the setup file which will install everything from scratch.
**Remember to make the setup file executable and place it in your home folder.**
> chmod +x setup_amd64.sh <br> 
> chmod +x setup_1386.sh <br>

# Adding Streams

Under the config/stream_setup.yaml, more streams can be added or removed, their properties can also 
be changed accordingly. 

## Camera-Stream Example

  stream-x:                 # Can name this whatever you choose
    type: cam               # cam - Will not look in ROS for a image. The video src is set in the 'source' parameter.
    source: "v4l2src device=/dev/video0 ! videoconvert ! videoscale ! video/x-raw,framerate=15/1,width=1280,height=720"  # Should work with most valid gstreamer piplines (ending with raw video) 
    mountpoint: /front      # Choose the mountpoint for the rtsp stream. This will be able to be accessed from rtsp://<server_ip>/front
    bitrate: 800            # bitrate for the h264 encoding.

## ROS Image Topic Example

  this-is-stream-42:        # Can name this whatever you choose
    type: topic             # topic - Image is sourced from a sensor_msgs::Image topic
    source: /usb_cam0/image_raw  # The ROS topic to subscribe to
    mountpoint: /back      # Choose the mountpoint for the rtsp stream. This will be able to be accessed from rtsp://<server_ip>/back
    caps: video/x-raw,framerate=10/1,width=640,height=480  # Set the caps to be applied after getting the ROS Image and before the x265 encoder.
    bitrate: 500            # bitrate for the h264 encoding.
    

# Running the Streams

Make the 2 files "step_1.sh" and "step_2.sh" executable. 
> chmod +x step_1.sh <br>
> chmod +x step_2.sh

# Using VLC to view the streams

Run this line in a new terminal to launch vlc and view your stream. 

> vlc --no-audio --avcodec-hw=any --sout-rtp-proto=udp --network-caching=300 --sout-udp-caching=0 --clock-jitter=0 --rtp-max-misorder=0 rtsp://<server_ip>:8554/<stream_mountpoint> :udp-timeout=0 enable-max-performance=1

The line below is default to the webcam of my laptop.

> vlc --no-audio --avcodec-hw=any --sout-rtp-proto=udp --network-caching=300 --sout-udp-caching=0 --clock-jitter=0 --rtp-max-misorder=0 rtsp://0.0.0.0:8554/front :udp-timeout=0 enable-max-performance=1
