{
  lib,
  pkgs,
  config,
  username ? "mking",
  ...
}:
{
  options = {
    my.alarm.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the alarm systemd service";
    };
  };
  config = lib.mkIf config.my.alarm.enable {
    systemd.user.timers."alarm" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "05:30:00";
        Unit = "alarm.service";
      };
      enable = true;
    };

    systemd.user.services."alarm" = {
      script = ''
        exec ${./alarm/alarm.sh}
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "${username}";
        RemainAfterExit = true;
      };
      path = with pkgs; [
        mpv
        socat
        bash
      ];
    };
  };
}
