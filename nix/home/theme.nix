{
  lib,
  config,
  pkgs,
  ...
}:
let
  font = "JetBrains Mono";
  font-mono = "JetBrains Mono";
  font-size = 10;
  font-package = pkgs.jetbrains-mono;

  theme-name = "TraditionalGreen";
  theme-package = pkgs.mate-themes;

  colors = {
    background = "#000000";
    foreground = "#ffffff";
    selectionBackground = "#5a5a5a";
    selectionForeground = "#ffffff";
    cursor = "#ffffff";
    cursorText = "#000000";

    black = "#1e1e1e";
    red = "#ff5f59";
    green = "#44bc44";
    yellow = "#d0bc00";
    blue = "#2fafff";
    magenta = "#feacd0";
    cyan = "#00d3d0";
    white = "#ffffff";

    brightBlack = "#535353";
    brightRed = "#ff7f9f";
    brightGreen = "#00c06f";
    brightYellow = "#dfaf7a";
    brightBlue = "#00bcff";
    brightMagenta = "#b6a0ff";
    brightCyan = "#6ae4b9";
    brightWhite = "#989898";
  };
in
{
  options = {
    my.font-size = lib.mkOption {
      type = lib.types.int;
      default = font-size;
      description = "Default font size";
    };
    my.font-mono = lib.mkOption {
      type = lib.types.str;
      default = font-mono;
      description = "Default monospace font to use";
    };
    my.font = lib.mkOption {
      type = lib.types.str;
      default = font;
      description = "Default mixed-width font to use";
    };
    my.font-package = lib.mkOption {
      type = lib.types.package;
      default = font-package;
      description = "Font package to use for the fonts";
    };

    my.theme.colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = colors;
      description = "Color palette";
    };
  };

  config = {
    gtk = {
      enable = true;

      iconTheme.name = "menta";
      iconTheme.package = pkgs.mate-icon-theme;

      theme.name = theme-name;
      theme.package = theme-package;
    };

    gtk.gtk4 = {
      theme.name = theme-name;
      theme.package = theme-package;
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk";
    };

    home.pointerCursor = {
      enable = true;
      package = pkgs.vanilla-dmz;
      gtk.enable = true;
      sway.enable = true;
      name = "DMZ-White";
    };
  };
}
