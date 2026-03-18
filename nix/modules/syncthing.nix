{
  username ? "mking",
  ...
}:

{
  services.syncthing = {
    user = "${username}";
    dataDir = "/home/${username}";
    enable = true;
  };
  # environment.systemPackages = with pkgs; [
  #   syncthingtray-minimal
  # ];
}
