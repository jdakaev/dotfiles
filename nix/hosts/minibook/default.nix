{
  config,
  lib,
  pkgs,
  username,
  host ? "minibook",
  ...
}:

{
  imports = [
    ../../modules/base.nix
    ./hardware-configuration.nix
  ];

  services.gvfs.enable = true;
  networking.firewall.enable = false;

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  programs.nh.enable = true;

  boot.tmp.useTmpfs = true;

  networking.hostName = host;
}
