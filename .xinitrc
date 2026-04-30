systemctl --user import-environment DISPLAY XAUTHORITY
dbus-update-activation-environment DISPLAY XAUTHORITY
export _JAVA_AWT_WM_NONREPARENTING=1

xrandr --output HDMI-1 --mode 1280x1024 --pos 0x0 --rotate left
xrandr --output DP-1 --primary --mode 1680x1050 --pos 1024x0 --rotate normal
# xrandr --output VGA-1 --rotate left

hsetroot -solid black

start() {
	if ! pgrep -f $1; then
		exec $@ &
	fi
}

# start picom --backend glx --vsync
start fastcompmgr
start dwmblocks
start vesktop

sleep 1 && exec dwm

# vim: set ft=bash :
