{
  pkgs,
  lib,
  config,
  ...
}:
{
  environment.systemPackages = [ pkgs.android-studio ];
}
