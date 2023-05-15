# capture screen to temp file
# use low scale to make capture & transform faster
grim -s 0.05 /tmp/swaylock.png

# blur screen
convert /tmp/swaylock.png -blur 0x1 -resize 3000% /tmp/swaylock.png

# lock
swaylock -i /tmp/swaylock.png

