{
  ...
}:
{
  fileSystems."/mnt" = {
    device = "10.0.0.90:/biggie/data_tr";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
    ];
  };
  # optional, but ensures rpc-statsd is running for on demand mounting
  boot.supportedFilesystems = [ "nfs" ];
}
