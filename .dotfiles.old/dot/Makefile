all : packages term menu ohmyzsh config 

packages:
	sudo sh -c 'echo "cedric ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/cedric && chmod 0440 /etc/sudoers.d/cedric'
	sudo apt-get -qq -y update
	sudo apt-get -qq -y upgrade
	sudo apt-get -qq -y install git make build-essential cmake ninja-build p7zip-full nnn vim vim-gtk3 zsh stterm ripgrep suckless-tools universal-ctags arandr curl wget tmux gettext unzip fzf rsync fd-find bat tree btop locales-all gcc silversearcher-ag pulseaudio pavucontrol caja flameshot trash-cli x11-utils libreadline-dev libx11-dev libxinerama-dev libxft-dev numlockx xdotool greetd xorg xinit bspwm sxhkd polybar fonts-font-awesome fonts-agave nodejs npm firmware-linux-free firmware-linux-nonfree i3lock

ohmyzsh:
	sudo apt-get -qq -y install zsh
	rm -fr ~/.oh-my-zsh 2> /dev/null
	wget -q "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
	chmod +x ./install.sh
	./install.sh --unattended
	rm -fr ./install.sh
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	chsh -s /bin/zsh

config:
	ln -sf -t ~/ ~/.dot/.vimrc
	ln -sf -t ~/ ~/.dot/.xinitrc
	ln -sf -t ~/ ~/.dot/.zshrc
	mkdir -p ~/.config
	ln -sf -t ~/.config/ ~/.dot/.config/bspwm
	ln -sf -t ~/.config/ ~/.dot/.config/polybar
	ln -sf -t ~/.config/ ~/.dot/.config/sxhkd
	ln -sf -t ~/ ~/.dot/.script

term:
	sudo make -C st clean install --silent
	sudo make -C st clean --silent

menu:
	sudo make -C dmenu clean install --silent
	sudo make -C dmenu clean --silent

.SILENT:

