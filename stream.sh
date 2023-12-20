#!/bin/bash
sudo media-ctl -v --device /dev/media1 --set-v4l2 '"ov5640 1-003c":0[fmt:YUYV8_2X8/720x576@1/30]'

while true
do
    ffmpeg -re -f v4l2 -video_size 720x576 -framerate 20 -i /dev/video1 -vf pad=736:576:8:0 -qp 22 -r 30 -pix_fmt nv12 -f rawvideo udp://192.168.0.17:2000/
done










