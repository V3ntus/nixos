{lib, ...}: let
  unboundHost = "127.0.0.1:5335";

  gladiusso_com = {
    A =
      [
        {
          host = "ai";
          ip = "192.168.2.12";
        }
        {
          host = "apps";
          ip = "192.168.2.8";
        }
        {
          host = "arr";
          ip = "192.168.2.4";
        }
        {
          host = "ca";
          ip = "192.168.2.18";
        }
        {
          host = "files";
          ip = "192.168.2.5";
        }
        {
          host = "games";
          ip = "192.168.2.11";
        }
        {
          host = "nix";
          ip = "192.168.2.10";
        }
        {
          host = "pve";
          ip = "192.168.2.3";
        }
        {
          host = "security";
          ip = "192.168.2.13";
        }
        {
          host = "vps";
          ip = "10.143.245.1";
        }
      ]
      ++ lib.lists.forEach [
        "adsb"
        "bookmarks"
        "budget"
        "chatgpt"
        "cnc"
        "dns"
        "ha"
        "healthcheckacme"
        "home"
        "jellyfin"
        "lidarr"
        "net"
        "photos"
        "portainer"
        "prowlarr"
        "proxmox"
        "radarr"
        "recipes"
        "sonarr"
        "transmission"
      ] (r: {
        host = r;
        ip = "192.168.2.6";
      });
  };
in {
  networking.firewall.allowedUDPPorts = [53 853];
  services.blocky = {
    enable = true;
    settings = {
      ports = {
        dns = 53;
        tls = 853;
      };

      upstreams = {
        groups = {
          default = [unboundHost];
        };
      };

      bootstrapDns = {
        upstream = "https://dns.quad9.net/dns-query";
        ips = ["9.9.9.9" "149.112.112.112"];
      };

      conditional = {
        mapping = {
          "gladiusso.com" = unboundHost;
        };
      };

      blocking = {
        denylists = {
          ads = [
            "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext"
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];
        };
      };
    };
  };

  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = ["127.0.0.1"];
        port = "5335";
        qname-minimisation = true;
        access-control = ["127.0.0.1/32 allow"];
        harden-glue = true;
        harden-dnssec-stripped = true;
        use-caps-for-id = false;
        prefetch = true;
        edns-buffer-size = 1232;

        hide-identity = true;
        hide-version = true;

        private-domain = "gladiusso.com";

        local-zone = ["\"gladiusso.com.\" transparent"];
        local-data = lib.lists.flatten (
          lib.lists.forEach
          gladiusso_com.A
          (record: "'" + record.host + ".gladiusso.com. A " + record.ip + "'")
        );
      };
      forward-zone = [
        {
          name = ".";
          forward-addr = ["9.9.9.9" "1.1.1.1"];
        }
      ];
    };
  };
}
