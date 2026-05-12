{
  config,
  pkgs,
  host,
  unstable,
  username ? "mking",
  ...
}:
{
  imports = [
    ../../home/base.nix
    ../../hosts/${host}/home.nix
  ];

  home.username = "mking";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "25.11";
  home.sessionPath = [
    "$HOME/dotfiles/.local/bin"
  ];
}
