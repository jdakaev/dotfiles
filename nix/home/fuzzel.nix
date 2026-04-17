{ config, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "${config.my.font}:size=${builtins.toString config.my.font-size}";
        terminal = "alacritty";
        layer = "overlay";
        exit-on-keyboard-focus-loss = "no";
      };

      border = {
        radius = 2;
      };

      colors = {
        background = "${builtins.replaceStrings [ "#" ] [ "" ] config.my.theme.colors.background}ff";
        text = "${builtins.replaceStrings [ "#" ] [ "" ] config.my.theme.colors.foreground}ff";
        selection = "${builtins.replaceStrings [ "#" ] [ "" ] config.my.theme.colors.blue}ff";
        selection-text = "${builtins.replaceStrings [ "#" ] [ "" ] config.my.theme.colors.cursorText}ff";
        prompt = "${builtins.replaceStrings [ "#" ] [ "" ] config.my.theme.colors.foreground}ff";
        input = "${builtins.replaceStrings [ "#" ] [ "" ] config.my.theme.colors.foreground}ff";
        match = "${builtins.replaceStrings [ "#" ] [ "" ] config.my.theme.colors.yellow}ff";
        selection-match = "${builtins.replaceStrings [ "#" ] [ "" ] config.my.theme.colors.yellow}ff";
        counter = "${builtins.replaceStrings [ "#" ] [ "" ] config.my.theme.colors.brightWhite}ff";
        border = "${builtins.replaceStrings [ "#" ] [ "" ] config.my.theme.colors.brightBlack}ff";
      };
    };
  };
}
