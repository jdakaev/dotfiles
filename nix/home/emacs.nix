{
  config,
  pkgs,
  unstable,
  minimal-emacs,
  org-mode-flake,
  ...
}:
{
  home.packages = [
    unstable.tdlib
    pkgs.gnumake
    pkgs.pkg-config
    pkgs.gcc
    org-mode-flake.packages.${pkgs.stdenv.hostPlatform.system}.org-mode
    pkgs.cmake
    pkgs.libtool
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
    ".emacs.d/org-mode-init.el" = {
      text = ''
        ;;; org-mode-init.el --- Load custom org-mode from Nix flake
        ;; Add the custom org-mode to load path before anything tries to require org
        (add-to-list 'load-path "${
          org-mode-flake.packages.${pkgs.stdenv.hostPlatform.system}.org-mode
        }/share/emacs/site-lisp")
        (require 'org)
      '';
    };
    ".emacs.d/nix-vars.el" = {
      text = ''
        (setq my/font-size ${builtins.toString config.my.font-size}0)
        (setq my/default-font "${config.my.font}")
        (setq my/default-font-mono "${config.my.font-mono}")
      '';
    };
  };
}
