#!/usr/bin/python
import sys

input          = sys.stdin.readline()
total_songs    = int(input.split()[0])
songs_to_print = int(input.split()[1])


songs = []
for song_number in range(1, total_songs + 1):
  line       = sys.stdin.readline()
  play_count = int(line.split()[0])
  song_name  = line.split()[1]
  rating     = play_count * (song_number / total_songs)
  songs.append ( {"song_name": song_name, "rating": rating, "play_count": play_count, "song_number": song_number} )


songs.sort(key=lambda x:(x['song_number'], -x['rating']))


count = 0
for sorted_song in reversed(songs):
  count += 1
  print sorted_song["song_name"]
  if count == songs_to_print: break


