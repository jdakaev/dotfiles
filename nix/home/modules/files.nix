{ config, pkgs, ... }:
{
  home.file = {
    ".zprofile" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.home.homeDirectory}/dotfiles/.zprofile;
    };
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.home.homeDirectory}/dotfiles/.config/nvim;
    };
    ".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.home.homeDirectory}/dotfiles/.config/waybar;
    };
    ".config/alacritty" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.home.homeDirectory}/dotfiles/.config/alacritty;
    };
  };
}
