{
  pkgs,
  lib,
  config,
  ...
}:
{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.ksystemlog # System log viewer
    kdePackages.sddm-kcm # SDDM configuration module
    wl-clipboard # Wayland copy/paste support
  ];
  programs.kdeconnect.enable = true;
}
