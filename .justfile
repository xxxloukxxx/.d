all : sudoers pack greetd bin zsh dotfiles suckless

@sudoers:
  [ -f /etc/sudoers.d/cedric ] || { sudo sh -c 'echo "cedric ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/cedric && chmod 0440 /etc/sudoers.d/cedric'; }

@pack:
  sudo apt-get -y -qq update && sudo apt-get -y -qq full-upgrade
  sudo apt-get -y -qq install vim make git nnn gcc sudo build-essential meson cmake ninja-build locales-all curl wget fzf tmux silversearcher-ag universal-ctags npm xinit xorg xdotool numlockx x11-utils arandr libreadline-dev libx11-dev libxinerama-dev libxft-dev libxrandr-dev clang-format vim-gtk3 fonts-agave fonts-hack fonts-hack-otf fonts-hack-ttf fonts-hack-web greetd dunst pavucontrol pulseaudio pulseaudio-utils trash-cli picom libxcb-util-dev firefox-esr rsync just moc zsh zsh-autosuggestions zsh-syntax-highlighting

@greetd:
  if ! grep -q startx /etc/greetd/config.toml; then \
    sudo patch -F 3 -c -u -s -u /etc/greetd/config.toml < .diff/greetd-patch.diff; \
  fi

@bin:
  sudo rsync -aqh .bin/* /usr/bin/

@zsh:
  sudo chsh -s /usr/bin/zsh cedric

@dotfiles:
  rsync -aqh .xinitrc ~/
  rsync -aqh .vimrc ~/
  rsync -aqh .zshrc ~/
  rsync -aqh .gitconfig ~/
  rsync -aqh .config ~/
  rsync -aqh .moc ~/
  chmod 644 ~/.moc/config

@suckless:
  sudo make -s -k -C .dev/dmenu clean install
  sudo make -s -k -C .dev/dwm clean install
  sudo make -s -k -C .dev/dwmblocks clean install
  sudo make -s -k -C .dev/nnn clean install
  sudo make -s -k -C .dev/noice clean install
  sudo make -s -k -C .dev/slock clean install
  sudo make -s -k -C .dev/st clean install
  sudo make -s -k -C .dev/fastcompmgr clean install
  sudo make -s -k -C .dev/dmenu clean
  sudo make -s -k -C .dev/dwm clean
  sudo make -s -k -C .dev/dwmblocks clean
  sudo make -s -k -C .dev/nnn clean
  sudo make -s -k -C .dev/noice clean
  sudo make -s -k -C .dev/slock clean
  sudo make -s -k -C .dev/st clean
  sudo make -s -k -C .dev/fastcompmgr clean

@get-dotfiles:
  rsync -aqh ~/.xinitrc ./
  rsync -aqh ~/.vimrc ./
  rsync -aqh ~/.zshrc ./
  rsync -aqh ~/.gitconfig ./
  rsync -aqh ~/.config/dunst ./.config/
  rsync -aqh ~/.config/nvim ./.config/
  rsync -aqh ~/.moc ./

# vi: set ts=2 sw=2: #
