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
    ../../home/modules.nix
    ../../hosts/${host}/home.nix
  ];

  home.username = "mking";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "25.11";
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/dotfiles/.local/bin"
  ];
}
