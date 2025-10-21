systemctl --user import-environment DISPLAY XAUTHORITY
dbus-update-activation-environment DISPLAY XAUTHORITY

export _JAVA_AWT_WM_NONREPARENTING=1

xrdb -merge ~/.Xresources

/usr/bin/display-lr.sh
# /usr/bin/feh --randomize --bg-fill ~/.w --no-xinerama

start() {
	if ! pgrep -f $1; then
		exec $@ &
	fi
}

start picom --backend glx
start vesktop
start dwmblocks
start mocp -S

sleep 1 && exec dwm

# vim: set ft=bash :
