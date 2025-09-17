# Env variables
systemctl --user import-environment DISPLAY XAUTHORITY
dbus-update-activation-environment DISPLAY XAUTHORITY

export XDG_SESSION_TYPE=x11

# Monitor
xrandr --output VGA-1 --rotation left

# WM
slstatus 2>&1 >/dev/null &
sleep 1 && exec dwm
