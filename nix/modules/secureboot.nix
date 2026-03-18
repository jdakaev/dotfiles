{
  pkgs,
  lib,
  config,
  lanzaboote,
  ...
}:
{
  options = {
    my.secureboot.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable secure boot with lanzaboote";
    };
  };

  config = lib.mkIf config.my.secureboot.enable {
    environment.systemPackages = with pkgs; [
      sbctl
    ];
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.initrd.systemd.enable = true;

    boot.lanzaboote = {
      autoGenerateKeys.enable = true;
      autoEnrollKeys.enable = true;
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
