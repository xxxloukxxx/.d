set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

@default: testing install-pkg sync-cfg put-conf fonts

@testing:
    @# Moving to testing
    sudo rm -fr /etc/apt/sources.list
    sudo rsync -aq etc/apt/ /etc/apt/
    sudo apt -y -qq update
    sudo DEBIAN_FRONTEND=noninteractive apt -y -qq --autoremove full-upgrade

@get-conf:
    @# Get configuration from ~/.config and ~
    # rsync -aq ~/.config/dunst ./.config/
    rsync -aq ~/.config/foot ./.config/
    rsync -aq ~/.config/fuzzel ./.config/
    rsync -aq ~/.config/obs-studio ./.config/
    rsync -aq ~/.config/waybar ./.config/
    rsync -aq ~/.config/hypr ./.config/
    rsync -aq ~/.config/nvim ./.config/
    rsync -aq ~/.config/mako ./.config/
    rsync -aq ~/.moc ./
    rsync -aq ~/.vimrc ./
    rsync -aq ~/.zshrc ./
    rsync -aq ~/.gitconfig ./
    rsync -aq ~/.XCompose ./

@put-conf:
    @# Put configuration to ~/.config and ~
    # rsync -aq .config/dunst ~/.config/
    rsync -aq .config/foot ~/.config/
    rsync -aq .config/fuzzel ~/.config/
    rsync -aq .config/obs-studio ~/.config/
    rsync -aq .config/hypr ~/.config/
    rsync -aq .config/waybar ~/.config/
    rsync -aq .config/nvim ~/.config/
    rsync -aq .config/mako ~/.config/
    rsync -aq .moc ~/
    rsync -aq .vimrc ~/
    rsync -aq .zshrc ~/
    rsync -aq .gitconfig ~/
    rsync -aq .XCompose ~/
    sudo rsync -aq .bin/ /usr/local/bin/

@install-pkg:
    @# Install hyprland and friends ...
    sudo apt -y -qq install rsync wget curl
    sudo apt -y -qq install vim vim-gtk3 make p7zip-full nnn gcc build-essential locales-all fzf tmux silversearcher-ag rsync just zsh zsh-syntax-highlighting zsh-autosuggestions figlet
    sudo apt -y -qq install hyprcursor-util hypridle hyprland-backgrounds hyprland-dev hyprland-guiutils hyprland-plugin-borders-plus-plus hyprland-plugin-hyprbars hyprland-plugin-hyprexpo hyprland-plugin-hyprfocus hyprland-plugin-hyprscrolling hyprland-plugin-hyprtrails hyprland-plugin-hyprwinwrap hyprland-plugin-xtra-dispatchers hyprland-protocols hyprland hyprlock hyprpaper hyprpicker hyprpolkitagent hyprwayland-scanner hyprwire-scanner
    sudo apt -y -qq install firefox-esr firefox-esr-l10n-fr qimgv greetd "fonts-hack*" fonts-agave pulseaudio-utils trash-cli pulseaudio pavucontrol fuzzel greetd p7zip-full foot clang clangd waybar npm dunst pipewire xdg-desktop-portal-hyprland qtwayland5 "qt6-wayland*" jq fnt grimshot moc
    sudo apt -y -qq install zsh "zsh-*"
    sudo chsh -s /usr/bin/zsh cedric

@sync-cfg:
    @# Sync /etc/ config files
    sudo rsync -aq etc/greetd/ /etc/greetd/

@fonts:
    @# Install fonts
    sudo apt -y -qq install p7zip-full fnt
    7z x -y -bb0 .fonts.7z
    rsync -aq .fonts ~/
    rm -fr .fonts
    fnt update
    fnt install agave
    fc-cache -r

@push:
    @# Push to github
    git add .
    git commit -m "$(date)"
    git push

@nopen:
    sudo make --silent -C .nopen clean install
    make --silent -C .nopen clean

# vim: ft=just:ts=2:sw=4:
