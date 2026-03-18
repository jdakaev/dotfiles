{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
}
