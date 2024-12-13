# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# Powerlevel10k config
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# export PATH="$PATH:/mnt/c/Program\ Files/WezTerm/wezterm.exe"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TMUX_CONF="$HOME/.config/tmux/tmux.conf"
export XDG_CONFIG_HOME="$HOME/.config"


# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share/zinit}/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# SSH-Agent
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

# aliases
alias vprod="NVIM_APPNAME=ProdNvim nvim"
alias ls="eza --icons=always"
alias la="ls -a"
alias v="nvim"
alias c="clear;ls"
alias conf="cd ~/.config"
alias wez="cd /mnt/c/Users/aleks/"
# alias wezterm="/mnt/c/Program Files/WezTerm/wezterm.exe"





source "${ZINIT_HOME}/zinit.zsh"

#----------------------------------------------------------------
# Prompt Themes

# Starship
# zinit ice as"command" from"gh-r" \
#           atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#           atpull"%atclone" src"init.zsh"
# zinit light starship/starship

# Roundy original
# zinit ice depth=1; zinit light nullxception/roundy

# Roundy fork
# zinit light metaory/zsh-roundy-prompt

# Pure
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure

# Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#---------------------------------------------------------------

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Snippets
# OMZP SNIPPETS LINK https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
# GIT https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
zinit snippet OMZP::git
zinit snippet OMZP::sudo
# ARCHLINUX https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux
zinit snippet OMZP::archlinux

# Load completions
autoload -U compinit && compinit
# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color --icons=always $realpath'

# Shell Integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Keybindings
bindkey '^f' autosuggest-accept
bindkey '^p' history_search_backward
bindkey '^n' history_search_forward

# History settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erease
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
