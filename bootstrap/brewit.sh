echo "Brewing.."
brew update
brew upgrade --all
brew install python
brew install vim --override-system-vi
brew install emacs --with-ctags --with-gnutls --with-mailutils --with-imagemagick --with-d-bus --with-cocoa
brew install fortune
brew install cask
brew install fasd
brew install the_silver_searcher
brew install tig
brew install ranger
brew install texinfo
brew install ispell
brew install valgrind --head
brew install coreutils
brew install moreutils
brew install findutils --with-default-names
brew install gnu-sed --with-default-names
brew install dark-mode
brew install tree
brew install thefuck
brew install mackup

brew tap homebrew/dupes
brew install homebrew/dupes/gdb --with-brewed-python
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen


echo "Brew casking..."
brew install caskroom/cask/brew-cask
brew tap caskroom/fonts

brew cask update
brew cask install chromium
brew cask install iterm2
brew cask install vlc
brew cask install emacs
brew cask install font-inconsolata
brew cask install font-inconsolata-for-powerline
