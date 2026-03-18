{ pkgs, ... }:
{
  services.gpg-agent.enable = true;
  services.gpg-agent.pinentry.package = pkgs.pinentry-qt;
  services.gpg-agent.pinentry.program = "pinentry-qt";
}
