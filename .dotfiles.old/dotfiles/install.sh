#/bin/bash
sudo apt-get -qq update
sudo apt-get -y -qq full-upgrade
sudo apt-get -y -qq install lightdm xorg i3 i3blocks picom
sudo apt-get -y -qq install fish rxvt-unicode xterm btop kitty
sudo apt-get -y -qq install xdg-utils dex
sudo apt-get -y -qq install suckless-tools numlockx 
sudo apt-get -y -qq install psmisc git sudo aptitude
sudo apt-get -y -qq install nnn fzf fd-find bat unzip p7zip-full vim lftp micro tree git catimg chafa rsstail
sudo apt-get -y -qq install gnupg2 curl build-essential software-properties-common apt-transport-https psmisc git sudo aptitude
sudo apt-get -y -qq install fonts-hack fonts-hack-ttf fonts-hack-otf fonts-hack-web fonts-font-awesome 
sudo apt-get -y -qq install libnotify-bin dunst feh polybar
sudo apt-get -y -qq install libreadline-dev libx11-dev libxinerama-dev libxft-dev
sudo apt-get -y -qq install pavucontrol pulseaudio alsa-utils
sudo apt-get -y -qq install openssh-server openssh-client
sudo apt-get -y -qq install neovim python3-neovim delta silversearcher-ag ripgrep bat vim-gtk3
sudo apt-get -y -qq install firmware-misc-nonfree
sudo apt-get -y -qq autoremove
sudo aptitude -y autoclean
sudo aptitude -y purge
sudo aptitude -y purge ~c 

cp -fr .config ~/
cp -fr .vim ~/
cp -fr .vimrc ~/
cp -fr .X* ~/
cp -fr .latexmkrc ~/
cp -fr .w ~/
cp -fr .fonts ~/
fc-cache -r

chsh -s /usr/bin/fish
