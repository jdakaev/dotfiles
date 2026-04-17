{
  config,
  ...
}:
{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    font = {
      normal = {
        family = config.my.font-mono;
      };
      size = config.my.font-size;
    };

    colors = {
      normal = {
        black = config.my.theme.colors.black;
        red = config.my.theme.colors.red;
        green = config.my.theme.colors.green;
        yellow = config.my.theme.colors.yellow;
        blue = config.my.theme.colors.blue;
        magenta = config.my.theme.colors.magenta;
        cyan = config.my.theme.colors.cyan;
        white = config.my.theme.colors.white;
      };
      bright = {
        black = config.my.theme.colors.brightBlack;
        red = config.my.theme.colors.brightRed;
        green = config.my.theme.colors.brightGreen;
        yellow = config.my.theme.colors.brightYellow;
        blue = config.my.theme.colors.brightBlue;
        magenta = config.my.theme.colors.brightMagenta;
        cyan = config.my.theme.colors.brightCyan;
        white = config.my.theme.colors.brightWhite;
      };
      cursor = {
        cursor = config.my.theme.colors.cursor;
        text = config.my.theme.colors.cursorText;
      };
      primary = {
        background = config.my.theme.colors.background;
        foreground = config.my.theme.colors.foreground;
      };
      selection = {
        background = config.my.theme.colors.selectionBackground;
        text = config.my.theme.colors.selectionForeground;
      };
    };
  };
}
