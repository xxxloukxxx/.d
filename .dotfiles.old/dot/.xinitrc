###
export XDG_SESSION_TYPE=x11

xrandr --output VGA-1 --primary --mode 1280x1024 --pos 0x0 --rotate left --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off

exec polybar &
exec bspwm
