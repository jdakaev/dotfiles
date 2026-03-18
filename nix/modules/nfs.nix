{
  ...
}:
{
  # fileSystems."/mnt" = {
  #   #device = "<redacted>";
  #   fsType = "nfs";
  #   options = [
  #     "x-systemd.automount"
  #     "noauto"
  #   ];
  # };
  # # optional, but ensures rpc-statsd is running for on demand mounting
  # boot.supportedFilesystems = [ "nfs" ];
}
