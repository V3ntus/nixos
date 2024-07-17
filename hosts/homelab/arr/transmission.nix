{
  services.transmission = {
    enable = true;

    openFirewall = true;
    openPeerPorts = true;
    openRPCPort = true;

    performanceNetParameters = true;

    settings = {
      download-dir = "/mnt/Download";
    };
  };
}
