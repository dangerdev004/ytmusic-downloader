#!/bin/sh
if command termux-reload-settings >/dev/null 2>&1
then  
echo "Enter the youtube link of the song or playlist: "
read link
if grep -q "playlist"  <<< "$link" ;
then
yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P /sdcard/Music -o '%(playlist_title)s/%(video_autonumber)s-%(title)s.%(ext)s' "$link"
output=$(yt-dlp --get-filename -o '%(playlist_title)s' --playlist-start 1 --playlist-end 1 "$link")
cd /sdcard/Music/"$output"
ls -1v | grep .mp3 > "$output".m3u
cd
else 
yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P /sdcard/Music -o "%(title)s.%(ext)s" "$link"
fi
else
echo "Enter the youtube link of the song or playlist: "
read link
if grep -q "playlist"  <<< "$link" ;
then
yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P ~/Music -o '%(playlist_title)s/%(video_autonumber)s-%(title)s.%(ext)s' "$link"
output=$(yt-dlp --get-filename -o '%(playlist_title)s' --playlist-start 1 --playlist-end 1 "$link")
cd ~/Music/"$output"
ls -1v | grep .mp3 > "$output".m3u
cd
else 
yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P ~/Music -o "%(title)s.%(ext)s" "$link"
fi
fi
