{
  pkgs,
  lib,
  config,
  unstable,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    unstable.opencode
    nodejs
    unstable.github-copilot-cli
    seahorse # for gnome-keyring for copilot
    ripgrep
    neovim
    fzf
    tmux
    lsof
    jq
    tree-sitter

    opus-tools
  ];
}
