{ config, pkgs, username ? "mking", ... }:
{
  # Add user to i2c group for DDC monitor control
  users.users.${username}.extraGroups = [ "i2c" ];

  # Create i2c group if it doesn't exist
  users.groups.i2c = {};

  # Enable i2c kernel module
  boot.kernelModules = [ "i2c-dev" ];

  services.clight = {
    enable = true;
    settings = {
      # Backlight settings
      backlight = {
        # Use DDC/CI for external monitors (requires i2c group membership)
        modules = [ "ddcutil" "sysfs" ];
        inhibit = false;
      };
      
      # Sensor settings for automatic brightness adjustment
      sensor = {
        # Try ALS sensor, fallback to camera
        modules = [ "als" "camera" ];
      };

      # Gamma (color temperature) settings
      gamma = {
        modules = [ "drm" "wayland" ];
      };

      # DPMS (screen power management) settings  
      dpms = {
        modules = [ "drm" "wayland" ];
      };

      # AC/Battery timeouts (milliseconds)
      ac_capture_timeouts = [
        120
        300
        60
      ];
      
      # Number of frames to capture for brightness sensing
      captures = 20;
      
      # Smooth transition when changing color temperature
      gamma_long_transition = true;
    };
  };
}
