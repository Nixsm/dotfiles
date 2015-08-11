#!/bin/bash

#set -e # exit if any non zero return code

echo "Copying ca-certificates to .ssh"
if [ ! -d "$HOME/.ssh" ]; then
	mkdir $HOME/.ssh
fi

ln -fs $(pwd)/ca-certificates.crt $HOME/.ssh/ca-certificates.crt

function do_brew {
	if [ ! hash brew 2>/dev/null ]; then
		echo "Installing homebrew"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	
	echo "Installing OSX packages"
    sh brewit.sh

    # link installed coreutils stuff
    sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
    
	echo "Installing system python packages"
	pip install --upgrade pip setuptools
	pip install virtualenvwrapper
}

function do_python {
	# if running any virtualenv, deactivate it.
	: ${VIRTUAL_ENV}? deactivate
	echo "Configuring virtualenvwrapper..."
	
	ENVW=$(which virtualenvwrapper.sh)
	export WORKON_HOME=$HOME/.virtualenvs
	export PROJECT_HOME=$HOME/workspace
	source $ENVW
	
	mkvirtualenv pyenv
	workon pyenv
	pip install --upgrade pip setuptools
	pip install -r requirements.txt
}

function do_git {
	echo "Installing git packages"
	if [ ! -d "$HOME/workspace" ]; then
		mkdir -p $HOME/workspace/git
	elif [ ! -d "$HOME/workspace/git" ]; then
		mkdir $HOME/workspace/git
	fi
	
	sh git_packages.sh
	
	echo "Configuring YCMD"
	(cd $HOME/workspace/git/ycmd/; git submodule update --init --recursive; ./build.py --clang-completer --omnisharp-completer --system-libclang)
	echo "Done git"
}

function do_zsh {
	if [ ! -d "$HOME/.zprezto" ]; then
		git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
		PRETZO="""setopt EXTENDED_GLOB
		for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
			  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
		  done"""
		zsh $PREZTO
	fi
	chsh -s /bin/zsh 
}

function do_mackup {
	cp -r ../.mackup* $HOME
	mackup restore
}

function do_others {
	sh osx.sh
    dark-mode
    echo "Copying emacs daemon launch script"
    cp ../emacs-daemon.plist ~/Library/LaunchAgents/emacs-daemon.plist
    echo "Copying random wallpaper script"
    cp ../random-wallpaper.plist ~/Library/LaunchAgents/random-wallpaper.plist

    open "/Users/nicholas/workspace/git/dotfiles/bootstrap/files/Monokai.itermcolors"
}

# do it!
do_brew
do_python
do_git
do_zsh
do_mackup
do_others

