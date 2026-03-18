{ config, pkgs, ... }:
{
  nixpkgs.config.input-fonts.acceptLicense = true;
  fonts.packages = with pkgs; [
    terminus_font
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    hack-font
    open-sans
    input-fonts
    #nerd-fonts.iosevka-term
    aporetic
  ];
}
