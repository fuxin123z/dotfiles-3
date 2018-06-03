#!/bin/bash

if [[ ! -e /usr/local/bin/brew ]]; then
    # quiet install brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || (echo "command failed" && exit 1)
else
    echo "$(brew --version)\n"
fi

if which git >/dev/null; then
    echo "$(git --version)\n"
else
    brew install git
fi

if which mas >/dev/null; then
    echo "mas version $(mas version)\n"
else
    brew install mas
fi

if [[ -d ~/dotfiles ]]; then
  	cd ~/dotfiles && git status
else
	git clone https://github.com/HeminWon/dotfiles.git ~/dotfiles
fi