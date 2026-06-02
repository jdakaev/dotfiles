{
  config,
  pkgs,
  username,
  ...
}:
{
  services.playerctld.enable = true;
  security.polkit.enable = true;
  programs.thunar.enable = true;
  programs.dconf.enable = true;
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/${username}";
    createHome = true;

    group = "users";
    extraGroups = [
      "networkmanager"
      "dialout"
      "disk"
    ];

    packages = with pkgs; [
      # is there a way to do this better
      libreoffice-still
      thunderbird
      calibre
      zathura

      gimp
      zsh-completions
      #sway
      fuzzel
      slurp
      wl-clipboard

      waybar
      emacs-pgtk

      pwvucontrol

      #koreader
      yt-dlp
      pass

      #orca-slicer

      wev
      python3

      jellyfin-mpv-shim
      mpv

      nomacs

      xarchiver
      rar

      halloy

      anki

      vesktop
      senpai

      ffmpeg

      #feishin
    ];
  };
}
