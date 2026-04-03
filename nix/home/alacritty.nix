{
  config,
  ...
}:
{
  programs.alacritty.enable = true;
  programs.alacritty.theme = "hyper";
  programs.alacritty.settings = {
    font = {
      normal = {
        family = config.my.font-mono;
      };
      size = config.my.font-size;
    };
  };
}
