#!/bin/bash

set -e # exit if any non zero return code

function do_brew {
	if [ ! $(hash brew 2>/dev/null) ]; then
		echo "Installing homebrew"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	
	echo "Installing OSX packages"
    sh brewit.sh

function do_git {
	echo "Installing git packages"
	if [ ! -d "$HOME/workspace" ]; then
		mkdir -p $HOME/workspace/git
	elif [ ! -d "$HOME/workspace/git" ]; then
		mkdir $HOME/workspace/git
	fi
	
	sh git_packages.sh
	
	echo "Configuring YCMD"
	(cd $HOME/workspace/git/ycmd/; git submodule update --init --recursive; ./build.py --clang-completer --system-libclang)
	echo "Done git"
}

function do_zsh {
	chsh -s /bin/zsh 
}

function do_mackup {
	cp -r ../.mackup* $HOME
	mackup restore
}

function do_others {
	sh osx.sh
    dark-mode

    open "/Users/nicholas/workspace/git/dotfiles/bootstrap/files/Monokai.itermcolors"
}

# do it!
do_brew
do_git
do_zsh
do_mackup
do_others

