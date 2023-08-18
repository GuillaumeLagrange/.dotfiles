# ENCULER DE TA RACE
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gnzh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    rust
    archlinux
    npm
    docker
    docker-compose
    yarn
    nvm
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

export PATH=~/.local/bin:$PATH
export PATH=~/scripts:$PATH
export PATH=~/scripts/local:$PATH
export PATH=~/i3lock-fancy:$PATH
export PATH=~/.cargo/bin:$PATH
# export PATH=/opt/gcc-arm-none-eabi-5_4-2016q3/bin:$PATH
export VISUAL=nvim
export EDITOR="$VISUAL"

alias vi="nvim"
alias vim="nvim"
alias cat="bat"
alias dualscreen="xrandr --output HDMI1 --auto --above eDP1"
alias generate-tags='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'
alias grst='git reset'
alias grst1='git reset HEAD~1'
alias gfu='gc --fixup'

alias s="kitty +kitten ssh"

# fzf aliases
alias gaf='git add $(git ls-files --modified --others --exclude-standard | fzf -m --height=40% --reverse)'
alias gch='git checkout $(git name-rev HEAD --name-only)'

zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:make:*' tag-order 'targets'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export AWS_SDK_LOAD_CONFIG=1

# man page colors
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# thefuck
eval $(thefuck --alias)

# direnv
eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.zshrc_local ]  && source ~/.zshrc_local
export FZF_DEFAULT_COMMAND='rg --files --hidden'

PATH="/home/glagrange/perl5/bin${PATH:+:${PATH}}"; export PATH;
export PATH="$HOME/tools/DataGrip-2021.1.1/bin:$PATH"
PERL5LIB="/home/glagrange/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/glagrange/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/glagrange/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/glagrange/perl5"; export PERL_MM_OPT;

# pnpm
export PNPM_HOME="/home/glagrange/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# fnm
export PATH="/home/glagrange/.local/share/fnm:$PATH"
eval "`fnm env`"
eval "$(fnm env --use-on-cd)"

# Stockly helpers
export STOCKLY_MAIN=$HOME/stockly/Main

smake()
{
        if [ -d "./StocklyContinuousDeployment" ]; then
                make -C './StocklyContinuousDeployment' $@
        else
                make -C './scd' $@
        fi
}
cdr() {
        cd "$STOCKLY_MAIN/$@"
}
compdef '_files -W "$STOCKLY_MAIN" -/' cdr
wr() {
        cdr $@ && code . && cargo watch
}
compdef '_files -W "$STOCKLY_MAIN" -/' wr
alias c="code ."
