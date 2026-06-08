{ pkgs, config, ... }:
{
  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
  programs.chromium.enable = true;
  #programs.imv.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
      "image/jpeg" = [ "org.nomacs.ImageLounge.desktop" ];
      "image/png" = [ "org.nomacs.ImageLounge.desktop" ];
      "image/webp" = [ "org.nomacs.ImageLounge.desktop" ];

      "inode/directory" = [ "thunar.desktop" ];

      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "x-scheme-handler/discord" = [ "vesktop.desktop" ];
    };
  };
}
