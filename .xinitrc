systemctl --user import-environment DISPLAY XAUTHORITY
dbus-update-activation-environment DISPLAY XAUTHORITY
export _JAVA_AWT_WM_NONREPARENTING=1

xrandr --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal

hsetroot -solid black

feh ~/.w/flower2.jpg --bg-fill

start() {
	if ! pgrep -f $1; then
		exec $@ &
	fi
}

# start picom --backend glx --vsync
# start fastcompmgr
start dunst
start dwmblocks
start vesktop

sleep 1 && exec dwm

# vim: set ft=bash :
