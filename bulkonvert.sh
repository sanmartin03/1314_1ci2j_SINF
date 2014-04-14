#!/bin/bash

# Script to convert all video files from a directory (parameter) into mp4 format file

# Diego Project

# Sanity checks
# ...
if [ ! -x /usr/bin/mencoder  ];
then
  echo "You must being instaled mencoder. Install it and try again."
  echo "run  'sudo apt-get install mencoder' for install it"
exit 1
fi


if [ $1 == "-h" ]; 
then
  echo ""
  echo "you must writte ./bulkonvert.sh [path]"
  echo "the path is the way to find the folder containing the video files"
  echo ""
  exit 2
fi

if [ $# != 1 ] ; 
then
  echo ""
  echo "bad parameter count, you must write the origin folder only"
  echo "you could write ./bulkonvert.sh -h for help"
  echo ""
  exit 3
fi

cadena1=$1
long=${#cadena1} 
if [ ${cadena1:long-1:1} != "/" ];
then
  echo "you don't write a valid path. example: home/videos/"   
  exit 4
fi        

if ! [ -d $1 ];
then
  echo "the folder you write not exist"   
  exit 5
fi

if ! [ -r $1 ];
then
  echo "you do not have read permissions for this folder"   
  exit 6
fi

if ! [ -w $1 ];
then
  echo "you do not have write permissions for this folder"   
  exit 7
fi

# Main code

ls -1 $1*.avi > videofiles

while read videofile
do
  lengthname=${#videofile}
  namefile=${videofile:0:$lengthname-4}
  mencoder "$videofile" -o "$namefile".mp4 -oac mp3lame -ovc lavc  -of lavf

done < videofiles
rm videofiles
