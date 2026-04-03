{
  config,
  ...
}:
{
  home.file = {
    ".config/fuzzel/fuzzel.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.my.dotfiles}/.config/fuzzel/fuzzel.ini;
    };
  };
}
