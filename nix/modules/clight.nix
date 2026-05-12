{ config, pkgs, ... }:
{
  services.clight = {
    enable = true;
    settings = {
      ac_capture_timeouts = [
        120
        300
        60
      ];
      captures = 20;
      gamma_long_transition = true;
    };
  };
}
