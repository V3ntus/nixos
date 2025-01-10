let
  base = locations: {
    inherit locations;

    # forceSSL = true;
    # enableACME = true;
  };
  proxy = ip: port:
    base {
      "/" = {
        proxyPass = "http://" + ip + ":" + toString port + "/";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_pass_header Authorization;
        '';
      };
    };
  virtualHosts = {
    "proxmox.gladiusso.com" = proxy "192.168.2.3" 8006;
    "portainer.gladiusso.com" = proxy "192.168.2.7" 9443; # docker-container
    "dns.gladiusso.com" = proxy "127.0.0.1" 5380;
    "home.gladiusso.com" = proxy "127.0.0.1" 8082;
    "ha.gladiusso.com" = proxy "192.168.2.14" 8123;

    "chatgpt.gladiusso.com" = proxy "192.168.2.12" 8081;
    "photos.gladiusso.com" = proxy "192.168.2.8" 3001;
    "budget.gladiusso.com" = proxy "192.168.2.7" 5006; # docker-container
    "recipes.gladiusso.com" = proxy "192.168.2.8" 8001;

    "jellyfin.gladiusso.com" = proxy "192.168.2.4" 8096;
    "transmission.gladiusso.com" = proxy "192.168.2.4" 9091;
    "prowlarr.gladiusso.com" = proxy "192.168.2.4" 9696;
    "radarr.gladiusso.com" = proxy "192.168.2.4" 7878;
    "sonarr.gladiusso.com" = proxy "192.168.2.4" 8989;
    "lidarr.gladiusso.com" = proxy "192.168.2.4" 8686;

    "adsb.gladiusso.com" = {
      locations."/" = {
        root = ./html;
        index = "adsb.html";
      };
    };
  };
in {
  networking.firewall.allowedTCPPorts = [80 443];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    # recommendedTlsSettings = true;

    inherit virtualHosts;
  };
}
