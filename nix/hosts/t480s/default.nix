{
  config,
  lib,
  pkgs,
  username,
  host,
  ...
}:

{
  imports = [
    ../../modules/base.nix
    ./hardware-configuration.nix
  ];

  networking.firewall = {
    enable = false;
  };
  services.undervolt = {
    enable = true;
    coreOffset = -100;
    gpuOffset = -70;
    analogioOffset = -50;
    uncoreOffset = -50;
  };

  environment.systemPackages = with pkgs; [
    picard
    ddcutil
    libxcvt
  ];
  services.udev.packages = [ pkgs.ns-usbloader ];
  # boot.kernelParams = [ "drm.edid_firmware=DP-4:edid/DP-4-75hz.bin" ];
  networking.hostName = "thiccpad";
  system.stateVersion = "25.05";
}
