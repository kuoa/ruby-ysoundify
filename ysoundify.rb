#!/usr/bin/env ruby
require_relative 'lib/sound_giraffe'

playlist = ARGV[0]

if playlist.nil?
  puts 'Please provide a valid URL'
else
  sound = SoundGiraffe.new playlist
  sound.download
end
