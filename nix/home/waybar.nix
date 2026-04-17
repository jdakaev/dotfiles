{ config, ... }:
{
  programs.waybar = {
    enable = true;
    style = ''
      ${builtins.readFile ../../.config/waybar/style.css}
      * {
        font-family: "${config.my.font-mono}";
        font-size: ${builtins.toString (config.my.font-size)}px;
      }
    '';
  };
}
