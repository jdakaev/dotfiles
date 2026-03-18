{
  config,
  lib,
  pkgs,
  username ? "mking",
  ...
}:
{
  imports = [
    ./alarm.nix
    #./android-dev.nix
    ./autologin.nix
    ./bluetooth.nix
    ./doas.nix
    ./fonts.nix
    ./laptop.nix
    ./latex.nix
    ./location.nix
    ./code.nix
    #./nfs.nix
    ./print.nix
    ./secureboot.nix
    ./ssh.nix
    ./syncthing.nix
    ./vpn.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  # Base system configuration: minimal core settings needed by all hosts
  boot.tmp.useTmpfs = true;

  #boot.loader.systemd-boot.enable = true;

  time.timeZone = "Europe/Minsk";

  environment.etc.hosts.enable = false;
  nix.optimise.automatic = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities

  environment.systemPackages = with pkgs; [
    # (inkscape-with-extensions.override { inkscapeExtensions = [ inkscape-extensions.textext ]; })
    # inkscape-with-extensions
    ethtool
    # nfs-utils
    git
    wget
    btop
    nmap
    python3
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = false;
    pulse.enable = true;
  };

  programs.zsh.enable = true;

  networking.networkmanager = {
    enable = true;
  };
  services.rpcbind.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
