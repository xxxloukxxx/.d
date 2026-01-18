all: suckless clean

everything: install suckless clean zsh dotfiles

install: bin
	[ -f /etc/sudoers.d/cedric ] || { \
	  sudo sh -c 'echo "cedric ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/cedric && chmod 0440 /etc/sudoers.d/cedric' ;\
	  }
	sudo apt-get -y -qq update && sudo apt-get -y -qq full-upgrade
	sudo apt-get -y -qq install vim make git nnn gcc build-essential cmake ninja-build locales-all \
	  curl wget fzf tmux silversearcher-ag universal-ctags npm xinit xorg xdotool numlockx x11-utils arandr \
	  libreadline-dev libx11-dev libxinerama-dev libxft-dev libxrandr-dev clang-format vim-gtk3 fonts-agave fonts-hack fonts-hack-otf fonts-hack-ttf fonts-hack-web greetd \
	  dunst pavucontrol pulseaudio pulseaudio-utils trash-cli picom libxcb-util-dev
	if ! grep -q startx /etc/greetd/config.toml; then \
	  sudo patch -F 3 -c -u -s -u /etc/greetd/config.toml < .diff/greetd-patch.diff; \
	  fi
	mkdir -p ~/.config
	# cp -fr .config/dunst ~/.config/
	# cp -fr .config/nvim ~/.config/
	cp -fr .config/.moc ~/

bin:
	sudo cp -Pfr .bin/* /usr/bin/

zsh:
	sudo apt-get -y -qq install zsh
	rm -fr ~/.oh-my-zsh
	wget --quiet "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
	chmod +x ./install.sh
	./install.sh --unattended
	rm -fr ./install.sh
	git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	sudo chsh -s /bin/zsh cedric

dotfiles:
	ln -nf .xinitrc .vimrc .zshrc .gitconfig ~/
	mkdir -p ~/.config/dunst
	ln -nf ./.config/dunst/dunstrc ~/.config/dunst/

suckless: dmenu dwm dwmblocks nnn noice rootclock slock st

dmenu:
	sudo make PREFIX=/usr -s -k -C .dev/dmenu clean install
	sudo make PREFIX=/usr -s -k -C .dev/dmenu clean

dwm:
	sudo make PREFIX=/usr -s -k -C .dev/dwm clean install
	sudo make PREFIX=/usr -s -k -C .dev/dwm clean

dwmblocks:
	sudo make PREFIX=/usr -s -k -C .dev/dwmblocks clean install
	sudo make PREFIX=/usr -s -k -C .dev/dwmblocks clean

nnn:
	sudo make PREFIX=/usr -s -k -C .dev/nnn clean install
	sudo make PREFIX=/usr -s -k -C .dev/nnn clean

noice:
	sudo make PREFIX=/usr -s -k -C .dev/noice clean install
	sudo make PREFIX=/usr -s -k -C .dev/noice clean

rootclock:
	sudo make PREFIX=/usr -s -k -C .dev/rootclock clean install
	sudo make PREFIX=/usr -s -k -C .dev/rootclock clean

slock:
	sudo make PREFIX=/usr -s -k -C .dev/slock clean install
	sudo make PREFIX=/usr -s -k -C .dev/slock clean

st:
	sudo make PREFIX=/usr -s -k -C .dev/st clean install
	sudo make PREFIX=/usr -s -k -C .dev/st clean

clean:
	sudo make PREFIX=/usr -s -k -C .dev/dmenu clean
	sudo make PREFIX=/usr -s -k -C .dev/dwm clean
	sudo make PREFIX=/usr -s -k -C .dev/dwmblocks clean
	sudo make PREFIX=/usr -s -k -C .dev/nnn clean
	sudo make PREFIX=/usr -s -k -C .dev/noice clean
	sudo make PREFIX=/usr -s -k -C .dev/rootclock clean
	sudo make PREFIX=/usr -s -k -C .dev/slock clean
	sudo make PREFIX=/usr -s -k -C .dev/st clean

.SILENT:

# vi: set ts=4 sw=2: #
