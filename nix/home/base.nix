{
  lib,
  pkgs,
  username,
  config,
  unstable,
  ...
}:
{
  options.my.dotfiles = lib.mkOption {
    type = lib.types.path;
    default = /${config.home.homeDirectory}/dotfiles;
    description = "Dotfiles repo directory";
  };
  imports = [
    ./theme.nix
    ./sway.nix
    ./cliphist.nix
    ./shell.nix
    ./apps.nix
    ./waybar.nix
    ./gpg.nix
    ./files.nix
    ./gtk.nix
    ./fuzzel.nix
    ./emacs.nix
    ./alacritty.nix
    ./cliamp.nix
  ];
}
