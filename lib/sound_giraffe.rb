require 'yt'
require 'youtube-dl'

YOUTUBE_CONFIG = 'yt.config'

class SoundGiraffe

  def initialize(playlist_url)
    @playlist_url = playlist_url
    config_youtube
  end

  def config_youtube
    File.open(YOUTUBE_CONFIG) do |file|
      Yt.configure do |config|
        config.api_key = file.readline
      end
    end
  end

  def id_to_url(id)
    'https://www.youtube.com/watch?v=' + id
  end

  def download
    playlist = Yt::Playlist.new url: @playlist_url

    download_options = {
        extract_audio: true,
        audio_format: 'mp3',
        output: playlist.title + '/%(title)s.%(ext)s'
    }

    videos = playlist.playlist_items

    videos.map do |video|
      puts 'Converting: ' + video.title
      video_url = id_to_url(video.video_id)
      YoutubeDL.download(video_url, download_options)
    end
  end

  private :config_youtube, :id_to_url
end