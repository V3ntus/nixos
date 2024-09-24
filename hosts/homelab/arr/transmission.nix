{pkgs, ...}: {
  services.transmission = {
    enable = true;
    webHome = pkgs.flood-for-transmission;

    openFirewall = true;
    openPeerPorts = true;
    openRPCPort = true;

    performanceNetParameters = true;

    settings = {
      download-dir = "/mnt/Download";
      incomplete-dir = "/mnt/Download/.partial";
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.*.*,192.168.2.*,10.143.245.*";
      rpc-username = "transmission";
      rpc-password = "transmission";
      rpc-authentication-required = true;
    };
  };
}
