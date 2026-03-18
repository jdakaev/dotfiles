{
  pkgs,
  lib,
  config,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    opencode
    ripgrep
    neovim
    fzf
    tmux
    lsof
    jq
    tree-sitter
  ];
}
