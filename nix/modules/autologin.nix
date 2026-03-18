{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    my.autologin.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the alarm systemd service";
    };
  };
  config = lib.mkIf config.my.autologin.enable {
    systemd.services."getty@tty1" = {
      overrideStrategy = "asDropin";
      serviceConfig.ExecStart = [
        ""
        "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} --autologin mking --noclear --keep-baud %I 115200,38400,9600 $TERM"
      ];
    };
  };
}
