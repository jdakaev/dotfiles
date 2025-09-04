path=(
  $path
  ~/.local/bin/
)

export BEMENU_OPTS='bemenu-run \
    --fn "Hack 12" \
    --no-cursor \
    --ignorecase \
    --no-spacing \
    --cf "#b19565" \
    --tf "#c9af82" \
    --nf "#756547" \
    --hf "#c9af82" \
    --hb "#996f26" \
    --ff "#917a53" \
    --af "#917a53" \
    --list 10 \
    --fixed-height \
    --margin 400 \
    -B 2 \
    --bdr "#c99c4d" \
    -c'
    #--ch 12 \
    #--line-height 13 \
    #--hp 12
    #--prompt "run:" \
if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then
  XDG_CURRENT_DESKTOP=sway
  #exec dbus-run-session sway
  exec sway
fi
