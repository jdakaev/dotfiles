{
  lib,
  config,
  pkgs,
  ...
}:
let
  font = "Input Sans";
  font-mono = "Input Mono";
  font-size = 10;
  font-package = pkgs.input-fonts;

  theme-name = "TraditionalGreen";
  theme-package = pkgs.mate.mate-themes;
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
  };

  config = {
    gtk = {
      enable = true;

      iconTheme.name = "Menta";
      iconTheme.package = pkgs.mate.mate-icon-theme;

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
