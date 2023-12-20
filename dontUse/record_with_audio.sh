#!/bin/bash
if pgrep -x "ffmpeg" > /dev/null
then
    echo FFmpeg is already running
    exit 1
fi

sudo media-ctl -v --device /dev/media1 --set-v4l2 '"ov5640 1-003c":0[fmt:YUYV8_2X8/720x576@1/30]'
#amixer --card 1 sset 'Auto Gain Control',0 off
#amixer --card 1 sset 'Mic',0 0

CURR_DATE=$(date +%d-%m-%YT%H-%M-%S)
#sudo ffmpeg -re -f v4l2 -video_size 720x576 -framerate 30 -i /dev/video1 -f alsa -ac 1 -i hw:1 -vf pad=736:576:8:0 -c:a libmp3lame -b:a 320k -qp 22 -r 30 -pix_fmt nv12 $CURR_DATE.mkv
#sudo ffmpeg -re -f v4l2 -video_size 720x576 -framerate 30 -i /dev/video1 -f alsa -ac 1 -i hw:1 -vf pad=736:576:8:0 -qp 22 -r 30 -pix_fmt nv12 $CURR_DATE.mkv
ffmpeg -re -f v4l2 -video_size 720x576 -framerate 30 -thread_queue_size 4096 -i /dev/video1 -f alsa -ac 1 -thread_queue_size 4096 -i hw:1 -vf pad=736:576:8:0 -c:a libmp3lame -qp 22 -r 30 -pix_fmt nv12 test.mkv
