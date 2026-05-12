{ config, ... }:
{
  programs.waybar = {
    enable = true;
    style = ''
      ${builtins.readFile ../../.config/waybar/style.css}
      * {
        font-family: "${config.my.font-mono}";
        font-size: ${builtins.toString (config.my.font-size * 1.5)}px;
      }
    '';
  };
  home.file = {
    ".config/waybar/config.jsonc" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.home.homeDirectory}/dotfiles/.config/waybar/config.jsonc;
    };
  };
}
