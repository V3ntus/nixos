let
  base = locations: {
    inherit locations;

    # forceSSL = true;
    # enableACME = true;
  };
  proxy = ip: port: base {
    "/" = {
      proxyPass = "http://" + ip + ":" + toString port + "/";
      extraConfig = ''
        proxy_pass_header Authorization;
      '';
    };
  };
  virtualHosts = {
    "proxmox.gladiusso.com" = proxy "192.168.2.3" 8006;
    "dns.gladiusso.com" = proxy "127.0.0.1" 5380;
    "home.gladiusso.com" = proxy "127.0.0.1" 8082;
    "chatgpt.gladiusso.com" = proxy "192.168.2.12" 8081;

    "transmission.gladiusso.com" = proxy "192.168.2.4" 9091;
    "prowlarr.gladiusso.com" = proxy "192.168.2.4" 9696;
    "radarr.gladiusso.com" = proxy "192.168.2.4" 7878;
  };
in {
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    # recommendedTlsSettings = true;

    inherit virtualHosts;
  };
}
