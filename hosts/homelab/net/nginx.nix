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
    "dns.gladiusso.com" = proxy "127.0.0.1" 5380;
    "home.gladiusso.com" = proxy "127.0.0.1" 8082;
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
