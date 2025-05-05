{lib, ...}: let
  base = locations: {
    inherit locations;

    forceSSL = true;
    useACMEHost = "healthcheckacme.gladiusso.com";
    acmeRoot = "/var/lib/acme/acme-challenge";
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
    "photos.gladiusso.com" = proxy "192.168.2.8" 2283;
    "budget.gladiusso.com" = proxy "192.168.2.7" 5006; # docker-container
    "recipes.gladiusso.com" = proxy "192.168.2.8" 8001;

    "jellyfin.gladiusso.com" = proxy "192.168.2.4" 8096;
    "transmission.gladiusso.com" = proxy "192.168.2.4" 9091;
    "prowlarr.gladiusso.com" = proxy "192.168.2.4" 9696;
    "radarr.gladiusso.com" = proxy "192.168.2.4" 7878;
    "sonarr.gladiusso.com" = proxy "192.168.2.4" 8989;
    "lidarr.gladiusso.com" = proxy "192.168.2.4" 8686;
    "bookmarks.gladiusso.com" = proxy "192.168.2.7" 3000;
    "cnc.gladiusso.com" = proxy "192.168.2.19" 80;

    "adsb.gladiusso.com" = {
      useACMEHost = "healthcheckacme.gladiusso.com";
      acmeRoot = "/var/lib/acme/acme-challenge";
      locations = {
        "/" = {
          root = ./html;
          index = "adsb.html";
        };
      };
    };

    "healthcheckacme.gladiusso.com" = {
      useACMEHost = "healthcheckacme.gladiusso.com";
      acmeRoot = "/var/lib/acme/acme-challenge";
      locations = {
        "/" = {
          extraConfig = ''
            add_header Content-Type text/plain;
            return 200 'healthy';
          '';
        };
      };
    };
  };
in {
  networking.firewall.allowedTCPPorts = [80 443];

  users.users.nginx.extraGroups = ["acme"];

  services.nginx = {
    enable = true;
    logError = "stderr info";
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    inherit virtualHosts;
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "joe@gladiusso.com";
      server = "https://ca.gladiusso.com/acme/acme/directory";
    };
    certs."healthcheckacme.gladiusso.com" = {
      group = "nginx";
      extraDomainNames = builtins.attrNames virtualHosts;
      webroot = "/var/lib/acme/acme-challenge";
    };
  };
}
