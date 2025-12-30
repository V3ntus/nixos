{lib, pkgs, ...}: let
  base = locations: {
    inherit locations;

    forceSSL = true;
    useACMEHost = "healthcheckacme.gladiusso.com";
    acmeRoot = "/var/lib/acme/acme-challenge";
  };
  proxy = {ip, port, extraConfig ? ""}:
    base {
      "/" = {
        proxyPass = "http://" + ip + ":" + toString port + "/";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_pass_header Authorization;
        '' + extraConfig;
      };
    };

  virtualHosts = {
    "proxmox.gladiusso.com" = proxy { ip = "192.168.2.3"; port = 8006; };
    "portainer.gladiusso.com" = proxy { ip = "192.168.2.7"; port = 9443; }; # docker-container
    "dns.gladiusso.com" = proxy { ip = "127.0.0.1"; port = 5380; };
    "home.gladiusso.com" = proxy { ip = "127.0.0.1"; port = 8082; };
    "ha.gladiusso.com" = proxy { ip = "192.168.2.14"; port = 8123; };

    "chatgpt.gladiusso.com" = proxy { ip = "192.168.2.12"; port = 8081; };
    "photos.gladiusso.com" = proxy { ip = "192.168.2.8"; port = 2283; };
    "budget.gladiusso.com" = proxy { ip = "192.168.2.7"; port = 5006; }; # docker-container
    "recipes.gladiusso.com" = proxy { ip = "192.168.2.8"; port = 8001; };

    "jellyfin.gladiusso.com" = proxy { ip = "192.168.2.12"; port = 8096; };
    "transmission.gladiusso.com" = proxy { ip = "192.168.2.4"; port = 9091; };
    "prowlarr.gladiusso.com" = proxy { ip = "192.168.2.4"; port = 9696; };
    "radarr.gladiusso.com" = proxy { ip = "192.168.2.4"; port = 7878; };
    "sonarr.gladiusso.com" = proxy { ip = "192.168.2.4"; port = 8989; };
    "lidarr.gladiusso.com" = proxy { ip = "192.168.2.4"; port = 8686; };
    "bookmarks.gladiusso.com" = proxy { ip = "192.168.2.7"; port = 3000; };
    "cnc.gladiusso.com" = proxy { ip = "192.168.2.19"; port = 80; extraConfig = ''
      client_max_body_size 1G;
    ''; };
    
    "wazuh.security.gladiusso.com" = proxy { ip = "192.168.2.13"; port = 443; };
    "netflow.security.gladiusso.com" = proxy { ip ="192.168.2.13"; port = 3000; };

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

    preStart = "/bin/sh -c 'until ${pkgs.host.outPath}/bin/host -A ca.gladiusso.com; do sleep 1; done'";

    inherit virtualHosts;
  };

  systemd.services.nginx = {
    after = [ "technitium-dns-server.service" ];
    wants = [ "technitium-dns-server.service" ];
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
