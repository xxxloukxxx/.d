systemctl --user import-environment DISPLAY XAUTHORITY
dbus-update-activation-environment DISPLAY XAUTHORITY
export _JAVA_AWT_WM_NONREPARENTING=1

xrandr --output VGA-1 --rotate left

start() {
	if ! pgrep -f $1; then
		exec $@ &
	fi
}

start picom --backend glx
start dwmblocks

sleep 1 && exec dwm

# vim: set ft=bash :
