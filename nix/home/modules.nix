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
    ./modules/theme.nix
    ./modules/sway.nix
    ./modules/cliphist.nix
    ./modules/shell.nix
    ./modules/apps.nix
    ./modules/waybar.nix
    ./modules/gpg.nix
    ./modules/files.nix
    ./modules/gtk.nix
    ./modules/fuzzel.nix
    ./modules/emacs.nix
    ./modules/alacritty.nix
    ./modules/cliamp.nix
  ];
}
