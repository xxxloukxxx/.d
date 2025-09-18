INSTALL = sudo apt-get -y -qq install
CP = cp -fr
LN = ln -f
RM = rm -fr
MD = sudo mkdir -p
WGET = wget --quiet
GCL = git clone --quiet
PATCH = patch -F 3 -c -u -s
SPATCH = sudo patch -F 3 -c -u -s
SCP = sudo cp -Pfr
SUDOSH = sudo sh -c
UPDATE = sudo apt-get -y -qq update && sudo apt-get -y -qq full-upgrade
M = sudo make PREFIX=/usr -s -k

# -------------------------------------------

all: clean install x zsh suckless dotfiles

suckless: wm menu status term lock

# -------------------------------------------

install:
	[ -f /etc/sudoers.d/cedric ] || { \
	  $(SUDOSH) 'echo "cedric ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/cedric && chmod 0440 /etc/sudoers.d/cedric' ;\
	  }
	$(UPDATE)
	$(INSTALL) vim make git nnn gcc build-essential cmake ninja-build locales-all curl wget fzf tmux silversearcher-ag
	$(INSTALL) x11-utils libreadline-dev libx11-dev libxinerama-dev libxft-dev libxrandr-dev clang-format vim-gtk3 fonts-agave greetd
	$(SCP) .bin/* /usr/bin/
	$(SPATCH) -u /etc/greetd/config.toml < .diff/greetd-patch.diff

x: install
	$(INSTALL) xinit xorg xdotool numlockx

zsh:
	$(INSTALL) zsh
	$(RM) ~/.oh-my-zsh
	$(WGET) "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
	chmod +x ./install.sh
	./install.sh --unattended
	$(RM) ./install.sh
	$(GCL) https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	$(GCL) https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	sudo chsh -s /bin/zsh cedric

# -------------------------------------------

menu:
	[ -d dmenu ] || { \
	  $(GCL) http://git.suckless.org/dmenu ;\
	  $(PATCH) -d dmenu < .diff/dmenu-fuzzyhighlight-5.3.diff ;\
	  $(PATCH) -d dmenu < .diff/dmenu-fuzzymatch-5.3.diff ;\
	  $(PATCH) -d dmenu < .diff/dmenu-caseinsensitive-20200523-db6093f.diff ;\
	  $(WGET) "https://tools.suckless.org/dmenu/scripts/dmenu_run_with_command_history/dmenu_run_history" -O dmenu/dmenu_run ;\
	  }
	$(CP) .h/dmenu.h dmenu/config.h
	$(M) -C dmenu clean install

# -------------------------------------------

term:
	[ -d st ] || { \
	  $(GCL) http://git.suckless.org/st ;\
	  $(PATCH) -d st < .diff/st-expected-anysize-0.9.diff ;\
	  $(PATCH) -d st < .diff/st-blinking_cursor-20230819-3a6d6d7.diff ;\
	  $(PATCH) -d st < .diff/st-scrollback-0.9.2.diff ;\
	  $(PATCH) -d st < .diff/st-vertcenter-20231003-eb3b894.diff ;\
	  }
	$(CP) .h/st.h st/config.h
	$(M) -C st clean install

# -------------------------------------------

wm:
	[ -d dwm ] || { \
	  $(GCL) http://git.suckless.org/dwm ;\
	  $(PATCH) -d dwm < .diff/dwm-focusonclick-20200110-61bb8b2.diff ;\
	  }
	$(CP) .h/dwm.h dwm/config.h
	$(M) -C dwm clean install

# -------------------------------------------

status:
	[ -d slstatus ] || { \
	  $(GCL) http://git.suckless.org/slstatus ;\
	  }
	$(CP) .h/slstatus.h slstatus/config.h
	$(M) -C slstatus clean install

# -------------------------------------------

lock:
	[ -d slock ] || { \
	  $(GCL) http://git.suckless.org/slock ;\
	  }
	$(CP) .h/slock.h slock/config.h
	$(M) -C slock clean install

# -------------------------------------------

dotfiles:
	$(LN) .xinitrc .vimrc .zshrc .gitconfig ~/

# -------------------------------------------

clean:
	$(RM) dmenu dwm st slstatus slock

# -------------------------------------------

.SILENT:

# vi: set ts=4 sw=2: #
