import os
import platform

def download_youtube_audio():
    if platform.system() == 'Windows':
        music_folder = os.path.expanduser('~\\Music')
    elif platform.system() == 'Linux':
        music_folder = os.path.expanduser('~/Music')
    elif platform.system() == 'Darwin':
        music_folder = os.path.expanduser('~/Music')
    elif platform.system() == 'Android':
        music_folder = '/sdcard/Music'
    else:
        print("Unsupported OS")
        return
    
    link = input("Enter the youtube link of the song or playlist: ")
    if "playlist" in link:
        os.system(f'yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\\\'if(gt(ih,iw),iw,ih)\\\':\\\'if(gt(iw,ih),ih,iw)\\\'" -P "{music_folder}" -o \'%(playlist_title)s/%(video_autonumber)s-%(title)s.%(ext)s\' "{link}"')
        output = os.popen(f'yt-dlp --get-filename -o \'%(playlist_title)s\' --playlist-start 1 --playlist-end 1 "{link}"').read().strip()
        os.chdir(f'"{music_folder}/{output}"')
        os.system(f'ls -1v | grep .mp3 > "{output}.m3u"')
        os.chdir('/')
    else:
        os.system(f'yt-dlp -x -f bestaudio --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\\\'if(gt(ih,iw),iw,ih)\\\':\\\'if(gt(iw,ih),ih,iw)\\\'" -P "{music_folder}" -o "%(title)s.%(ext)s" "{link}"')

if __name__ == "__main__":
    download_youtube_audio()
