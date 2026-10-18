set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

@all: packages config compile

@config:
	rsync -aqh .vimrc ~/
	rsync -aqh .wlinitrc ~/
	rsync -aqh .zshrc ~/
	rsync -aqh .gitconfig ~/
	rsync -aqh .config/ ~/.config/
	sudo rsync -aqh .bin/* /usr/bin/
	sudo chsh -s /usr/bin/zsh cedric
	[ -f /etc/sudoers.d/cedric ] || { sudo sh -c 'echo "cedric ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/cedric && chmod 0440 /etc/sudoers.d/cedric'; }

@compile:
	sudo make -C .dev/dwl clean install
	sudo make -C .dev/someblocks clean install
	sudo make -C .dev/dmenu clean install
	make -C .dev/dwl clean
	make -C .dev/someblocks clean
	make -C .dev/dmenu clean

@packages:
	sudo apt-get -y -qq update && sudo apt-get -y -qq full-upgrade
	sudo apt-get -y -qq install libcairo2-dev libdbus-1-dev libfcft-dev libinput-dev libpango1.0-dev libpixman-1-dev libpulse-dev libpulse-dev libtllist-dev libwayland-dev libwlroots-0.18-dev libxkbcommon-dev
	sudo apt-get -y -qq install libxcb-composite0-dev libxcb-cursor-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-dri2-0-dev libxcb-dri3-dev libxcb-errors-dev libxcb-ewmh-dev libxcb-glx0-dev libxcb-icccm4-dev
	sudo apt-get -y -qq install libxcb-image0-dev libxcb-imdkit-dev libxcb-keysyms1-dev libxcb-present-dev libxcb-randr0-dev libxcb-record0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-res0-dev
	sudo apt-get -y -qq install libxcb-screensaver0-dev libxcb-shape0-dev libxcb-shm0-dev libxcb-sync-dev libxcb-util-dev libxcb-util0-dev libxcb-xf86dri0-dev libxcb-xfixes0-dev libxcb-xinerama0-dev
	sudo apt-get -y -qq install libxcb-xinput-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-xtest0-dev libxcb-xv0-dev libxcb-xvmc0-dev libxcb1-dev
	sudo apt-get -y -qq install wayland-protocols wlr-randr xwayland wl-clipboard
	sudo apt-get -y -qq install fonts-agave fonts-dejavu-core fonts-dejavu-mono fonts-droid-fallback fonts-freefont-ttf fonts-hack fonts-hack-otf fonts-hack-ttf fonts-hack-web fonts-lato fonts-liberation fonts-liberation-sans-narrow fonts-noto-mono fonts-urw-base35 foot
	sudo apt-get -y -qq install xdg-desktop-portal xdg-desktop-portal-wlr pipewire wireplumber

# vi: set ft=make ts=2 sw=2: #


