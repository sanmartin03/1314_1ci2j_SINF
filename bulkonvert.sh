#!/bin/bash

# Script to convert all video files from a directory (parameter) into mp4 format file

# Diego Project

# Sanity checks
# ...

if [ $1 == "-h" ]; 
then
  echo ""
  echo "you must writte ./bulkonvert.sh [path]"
  echo "the path is the way to find the folder containing the video files"
  echo ""
  exit 1
else
  if [ $# != 1 ] ; 
  then
    echo ""
    echo "bad parameter count"
    echo "you could write ./bulkonvert.sh -h for help"
    echo ""
    exit 2
  else
# Main code

    ls -1 $1*.avi > videofiles

    while read videofile
    do
echo $videofile
	lengthname=${#videofile}
echo $lengthname
	namefile=${videofile:0:$lengthname-4}
echo $namefile
  	mencoder "$videofile" -o "$namefile".mp4 -oac mp3lame -ovc lavc -lavcopts vcodec=mpeg1video -of mpeg

    done < videofiles
    rm videofiles
  fi
fi