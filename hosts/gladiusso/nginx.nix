{pkgs, ...}: {
  systemd.services.wedding-server = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "wedding NextJS server";
    path = [ "/run/current-system/sw" pkgs.nodejs_23 ];
    serviceConfig = {
      Type = "exec";
      User = "joe";
      Environment="PORT=3001";
      WorkingDirectory="/var/www/wedding.gladiusso.com";
      ExecStart = ''${pkgs.nodejs_23}/bin/npm run start'';
    };
  };

  services.nginx = {
    enable = true;
    package = pkgs.nginxStable.override {openssl = pkgs.libressl;};
    statusPage = true; # for Longview
    recommendedProxySettings = true;

    virtualHosts = {
      "gladiusso.com" = {
        addSSL = true;
        enableACME = true;
        root = "/var/www/gladiusso.com";
      };

      "music.gladiusso.com" = {
        addSSL = true;
        enableACME = true;
        root = "/var/www/music.gladiusso.com";
        locations."/pages/" = {
          tryFiles = "$uri $uri.html";
        };
      };

      "dev.gladiusso.com" = {
        addSSL = true;
        enableACME = true;
        root = "/var/www/dev.gladiusso.com";
      };

      "mc.gladiusso.com" = {
        addSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://192.168.2.11:8100";
        };
      };

      "wedding.gladiusso.com" = {
        addSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:3001";
        };
      };

      "backthehox.com" = {
        addSSL = true;
        enableACME = true;
        root = "/var/www/backthehox";
      };

      "thejoalition.org" = {
        addSSL = true;
        enableACME = true;
        root = "/var/www/thejoalition.org";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "joe@gladiusso.com";
    certs."gladiusso.com".extraDomainNames = ["music.gladiusso.com" "dev.gladiusso.com" "mc.gladiusso.com"];
  };
}
