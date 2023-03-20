#!/bin/sh

# Define Color Variables

BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Checking whether the shell is in Termux app on Android

if command termux-reload-settings >/dev/null 2>&1
 then

# Android

  read -n 1000000 -t 0.001
  echo -e "${GREEN}\nEnter the youtube link of the song or playlist:${NC}\n "
  read link

# Checking if the given link is for a playlist or a single

   if grep -q "playlist"  <<< "$link" ;
    then

# Playlist (Android)

     yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P /sdcard/Music -o '%(playlist_title)s/%(title)s-%(id)s.%(ext)s' --exec 'echo "%(title)s-%(id)s.%(ext)s" >> /sdcard/Music/"%(playlist_title)s"/"%(playlist_title)s.m3u"' "$link"

# Read yt-dlp documantation for more info

   else

# Single (Android)

    yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P /sdcard/Music -o "%(title)s-%(id)s.%(ext)s" "$link"
   fi
else

# Bash/Zsh

 read -n 1000000 -t 0.001
 echo -e "${GREEN}\nEnter the youtube link of the song or playlist:${NC}\n "
 read link

# Playlist

  if grep -q "playlist"  <<< "$link" ;
   then
    yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P ~/Music -o '%(playlist_title)s/%(title)s-%(id)s.%(ext)s' --exec 'echo -e "%(title)s-%(id)s.%(ext)s" >> ~/Music/"%(playlist_title)s"/"%(playlist_title)s.m3u"' "$link"
  else

# Single

   yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P ~/Music -o "%(title)s-%(id)s.%(ext)s" "$link"
  fi
fi

echo -e "${GREEN}\nFor more information checkout: https://github.com/dangerdev004/ytmusic-downloader/#readme${NC}"
