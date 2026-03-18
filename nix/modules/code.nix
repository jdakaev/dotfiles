{
  pkgs,
  lib,
  config,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ripgrep
    neovim
    fzf
    tmux
    opencode
    lsof
      jq
      tree-sitter
  ];
}
