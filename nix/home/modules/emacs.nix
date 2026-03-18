{
  config,
  pkgs,
  unstable,
  minimal-emacs,
  ...
}:
{
  home.packages = [
    unstable.tdlib
    pkgs.gnumake
    pkgs.pkg-config
    pkgs.gcc
  ];
  home.file = {
    ".emacs.d" = {
      source = minimal-emacs;
      recursive = true;
    };
    ".emacs.d/post-init.el" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.my.dotfiles}/.emacs.d/post-init.el;
    };
    ".emacs.d/pre-init.el" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.my.dotfiles}/.emacs.d/pre-init.el;
    };
    ".emacs.d/pre-early-init.el" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.my.dotfiles}/.emacs.d/pre-early-init.el;
    };
    ".emacs.d/post-early-init.el" = {
      source = config.lib.file.mkOutOfStoreSymlink /${config.my.dotfiles}/.emacs.d/post-early-init.el;
    };
    ".emacs.d/telega.el" = {
      text = ''
        (setq telega-server-libs-prefix "${unstable.tdlib}")
      '';
    };
  };
}

