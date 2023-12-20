#!/bin/bash
if pgrep -x "ffmpeg" > /dev/null
then
    echo FFmpeg is already running
    exit 1
fi

sudo media-ctl -v --device /dev/media1 --set-v4l2 '"ov5640 1-003c":0[fmt:YUYV8_2X8/720x576@1/30]'
#amixer --card 1 sset 'Auto Gain Control',0 off
#amixer --card 1 sset 'Mic',0 0

while true
do
    ffmpeg -re -f v4l2 -video_size 720x576 -framerate 30 -i /dev/video1 -f alsa -ac 1 -i hw:1 -vf pad=736:576:8:0 -c:a libmp3lame -qp 22 -r 30 -pix_fmt nv12 -f mpegts udp://192.168.0.17:2000/
    sleep 1.2
done













