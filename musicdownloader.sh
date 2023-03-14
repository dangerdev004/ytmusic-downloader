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

     yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P /sdcard/Music -o '%(playlist_title)s/%(video_autonumber)s-%(title)s.%(ext)s' "$link"
     output=$(yt-dlp --get-filename -o '%(playlist_title)s' --playlist-start 1 --playlist-end 1 "$link")
      cd /sdcard/Music/"$output"

# Read yt-dlp documantation for more info

      ls -1v | grep .mp3 > "$output".m3u
      cd
   else

# Single (Android)

    yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P /sdcard/Music -o "%(title)s.%(ext)s" "$link"
   fi
else

# Bash/Zsh

 read -n 1000000 -t 0.001
 echo -e "${GREEN}\nEnter the youtube link of the song or playlist:${NC}\n "
 read link

# Playlist

  if grep -q "playlist"  <<< "$link" ;
   then
    yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P ~/Music -o '%(playlist_title)s/%(video_autonumber)s-%(title)s.%(ext)s' "$link"
    output=$(yt-dlp --get-filename -o '%(playlist_title)s' --playlist-start 1 --playlist-end 1 "$link")
     cd ~/Music/"$output"
     ls -1v | grep .mp3 > "$output".m3u
     cd
  else

# Single

   yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P ~/Music -o "%(title)s.%(ext)s" "$link"
  fi
fi

echo -e "For more information checkout: https://github.com/dangerdev004/ytmusic-downloader/#readme"
