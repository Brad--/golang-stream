#!/bin/sh
# Create HLS segments from input .mp3

if [ ${#} -lt 2 ]; then
	echo "./segment-mp3.sh <input filename> <output name>"
	echo "Ex:"
	echo "./segment-mp3.sh ../mp3s/punisher--phoebe-bridgers.mp3 punisher"
	exit 1
fi

songs_dir="./assets/songs"

cd ${songs_dir} && mkdir ${2} && cd ${2}

ffmpeg  -i ${1} \
	-c:a libmp3lame \
	-b:a 128k \
	-map 0:0 \
	-f segment \
	-segment_time 10 \
	-segment_list ${2}.m3u8 \
	-segment_format mpegts ${2}%03d.ts
