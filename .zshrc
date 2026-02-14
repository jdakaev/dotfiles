autoload -Uz compinit promptinit
bindkey -v
promptinit

prompt walters
zstyle ':completion:*' menu select

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

alias vi='nvim'
alias vim='nvim'
alias ls='ls --color=auto'
alias ll='ls -la'


alias sudo='doas'

alias dotfiles='git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

alias up='sudo awg-quick up amnezia_for_awg.conf'
alias down='sudo awg-quick down amnezia_for_awg.conf'
# https://github.com/mubin6th/MinimalSway/blob/master/sway/bemenu.sh
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)


lazy_load_nvm() {
  unset -f node nvm npm
  export NVM_DIR=~/.nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

node() {
  lazy_load_nvm
  node $@
}

nvm() {
  lazy_load_nvm
  nvm $@
}

npm() {
  lazy_load_nvm
  npm $@
}

function run-tmux-sessionizer { tmux-sessionizer.sh; zle redisplay; }
zle -N run-tmux-sessionizer
bindkey '^f' run-tmux-sessionizer

export NIX_PATH="nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/home/mking/.nix/configuration.nix:/nix/var/nix/profiles/per-user/root/channels"
[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
