~/.screenlayout/default.sh &
setxkbmap -layout gb -variant dvorak
#setxkbmap -layout gb -variant  dvorak -option ctrl:swapcaps
#setxkbmap -layout gb -variant  dvorak -option ctrl:nocaps
xmodmap ~/.Xmodmap &
xmodmap -e "clear mod5"
xmodmap -e "keycode 108 = Alt_L"
mpd &
xset b off
exec awesome
