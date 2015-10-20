~/.screenlayout/default.sh &
setxkbmap -layout gb -variant dvorak
setxkbmap -layout gb -variant  dvorak -option ctrl:swapcaps
setxkbmap -layout gb -variant  dvorak -option ctrl:nocaps
xmodmap ~/.Xmodmap &
mpd &
xset b off
exec awesome
