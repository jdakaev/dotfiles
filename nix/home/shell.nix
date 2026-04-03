{ lib, pkgs, ... }:
{
  home.shellAliases = {
    ll = "ls -l";
    upd = "sudo nixos-rebuild switch";
  };

  programs.zsh = {
    envExtra = "source ~/.zaliases";
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = lib.mkOrder 1000 ''
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

      function run-tmux-sessionizer { tmux-sessionizer.sh; zle redisplay; }
      zle -N run-tmux-sessionizer
      bindkey '^f' run-tmux-sessionizer
      [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}

      source <(fzf --zsh)
    '';

    history.size = 10000;
  };
  programs.direnv.enable = true;
}
