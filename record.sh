sudo media-ctl -v --device /dev/media1 --set-v4l2 '"ov5640 1-003c":0[fmt:YUYV8_2X8/720x576@1/30]'
sudo ffmpeg -re -f v4l2 -video_size 720x576 -i /dev/video1 -vf pad=736:576:0:0 -qp 22 -pix_fmt nv12 single_output.mp4

