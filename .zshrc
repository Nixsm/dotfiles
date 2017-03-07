# source zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# manage zplug itself
zplug "zplug/zplug"

zplug "zsh-users/zsh-autosuggestions"

# use double quotes - up-arrow history
zplug "zsh-users/zsh-history-substring-search"

# additional completion for zsh
zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-syntax-highlighting"
zplug "modules/completion", as:plugin, from:prezto

# base16-shell
BASE16_SCHEME="monokai"
zplug "chriskempson/base16-shell", use:"scripts/base16-$BASE16_SCHEME.sh"

zplug "themes/gozilla", as:theme, from:oh-my-zsh

zstyle ':completion:*' menu select



# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
    zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load

############################# END OF ZPLUG #############################

# zsh variables
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000  # internal history
SAVEHIST=10000  # history file

# zsh options
setopt HIST_IGNORE_SPACE # do not record an event starting with a space
setopt SHARE_HISTORY # share history between sessions
setopt INC_APPEND_HISTORY # write to the history file immediately, not when the shell exits
setopt AUTO_CD              # Auto changes to a directory without typing cd.

## key bindings
# vi mode
KEYTIMEOUT=1 # Prevents key timeout lag.
bindkey -v

# Bind UP and DOWN arrow keys for subsstring search.
if zplug check zsh-users/zsh-history-substring-search; then
	zmodload zsh/terminfo
	bindkey "$terminfo[cuu1]" history-substring-search-up
	bindkey "$terminfo[cud1]" history-substring-search-down
fi

# exports
export PROJECT_HOME=$HOME/workspace
export EDITOR=vim
export VISUAL=vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export KEYTIMEOUT=1 # vim mode key lag
export MAKEFLAGS="-j4 -l5"

## aliases
alias dotfiles="cd ~/workspace/git/dotfiles"
alias fucking='sudo'
alias vi="vim"
alias lessf="less +F"
alias tmux="TERM=xterm-256color tmux"
alias ls="ls -G"

# fasd aliases
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

alias lsusb="ioreg -p IOUSB -w0 | sed 's/[^o]*o //; s/@.*$//' | grep -v '^Root.*'"

alias g="git"

eval "$(fasd --init auto)"
