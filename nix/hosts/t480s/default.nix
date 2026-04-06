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
  my.alarm.enable = true;
  services.undervolt = {
    enable = true;
    coreOffset = -100;
    gpuOffset = -70;
    analogioOffset = -50;
    uncoreOffset = -50;
  };

  environment.systemPackages = with pkgs; [
    picard
  ];
  networking.hostName = "thiccpad";
  system.stateVersion = "25.05";
}
