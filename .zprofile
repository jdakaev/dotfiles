export SDL_VIDEODRIVER=wayland 
export ANKI_WAYLAND=1
if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then
  XDG_CURRENT_DESKTOP=sway
  exec sway
fi
