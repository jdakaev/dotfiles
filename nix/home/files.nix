{ config, pkgs, ... }:
{
  home.file = {
    ".zprofile" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.home.homeDirectory}/dotfiles/.zprofile;
    };
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.home.homeDirectory}/dotfiles/.config/nvim;
    };
    ".config/waybar/config.jsonc" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.home.homeDirectory}/dotfiles/.config/waybar/config.jsonc;
    };
  };
}
