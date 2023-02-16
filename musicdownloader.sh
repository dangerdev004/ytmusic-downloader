echo "Enter the youtube link of the song or playlist: "
read link
if grep -q "playlist"  <<< "$link" ;
then 
 echo "Enter the name of the playlist: "
 read playname
 mkdir ~/Music/sources
 mkdir ~/Music/sources/"$playname"
 yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P ~/Music/sources/"$playname" -o "%(video_autonumber)s-%(title)s.%(ext)s".mp3 $link
 cd ~/Music/sources/"$playname"
 ls -1v | grep .mp3 > "$playname".m3u 
 mkdir ~/Music/"$playname"
cp *.mp3 ~/Music/"$playname"
 mv "$playname".m3u ~/Music/"$playname"
 cd
 rm -rf ~/Music/sources/
 else 
 echo "Enter the name of the song: "
 read name
 yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" -P ~/Music -o "$name".mp3 "$link"
 fi
