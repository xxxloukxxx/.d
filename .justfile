set quiet

all : sudoers apt-testing pack greetd bin zsh dotfiles suckless

@sudoers:
  [ -f /etc/sudoers.d/cedric ] || { echo "cedric ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/cedric >/dev/null && sudo chmod 0440 /etc/sudoers.d/cedric; }

@apt-testing:
    sudo bash -c 'printf "Package: *\nPin: release a=stable\nPin-Priority: 900\n\nPackage: *\nPin: release a=testing\nPin-Priority: 90\n" > /etc/apt/preferences.d/99-testing'
    sudo bash -c 'printf "Types: deb\nURIs: http://deb.debian.org/debian/\nSuites: testing\nComponents: main\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg\n" > /etc/apt/sources.list.d/testing.sources'
    sudo apt-get -y -qq update

@pack:
  sudo apt-get -y -qq update && sudo apt-get -y -qq full-upgrade
  sudo apt-get -y -qq install \
    build-essential meson cmake ninja-build gcc clang-format \
    libreadline-dev libx11-dev libxinerama-dev libxft-dev libxrandr-dev libxcb-util-dev libcrypt-dev \
    fonts-agave fonts-hack fonts-hack-otf fonts-hack-ttf fonts-hack-web \
    vim vim-gtk3 git nnn sudo locales-all curl wget fzf tmux silversearcher-ag universal-ctags npm \
    xinit xorg xdotool numlockx x11-utils arandr greetd dunst pavucontrol pulseaudio pulseaudio-utils \
    trash-cli picom firefox-esr rsync just moc zsh zsh-autosuggestions zsh-syntax-highlighting

@greetd:
  if ! grep -q startx /etc/greetd/config.toml; then \
    sudo patch -F 3 -c -u -s -u /etc/greetd/config.toml < .diff/greetd-patch.diff; \
  fi

@bin:
  sudo rsync -aqh .bin/* /usr/bin/

@zsh:
  [ "$(getent passwd cedric | cut -d: -f7)" = "/usr/bin/zsh" ] || sudo chsh -s /usr/bin/zsh cedric

@dotfiles:
  rsync -aqh .xinitrc .vimrc .zshrc .gitconfig .config .moc ~/
  chmod 644 ~/.moc/config

@suckless:
  for proj in dmenu dwm dwmblocks nnn noice slock st fastcompmgr; do \
    if [ -d ".dev/$proj" ]; then \
      sudo make -s -k -C ".dev/$proj" clean install && sudo make -s -k -C ".dev/.dev/$proj" clean 2>/dev/null || sudo make -s -k -C ".dev/$proj" clean; \
    fi \
  done

@get-dotfiles:
  rsync -aqh ~/.xinitrc ~/.vimrc ~/.zshrc ~/.gitconfig ~/.moc ./
  mkdir -p ./.config
  rsync -aqh ~/.config/dunst ~/.config/nvim ./.config/

# vi: set ts=2 sw=2: #
