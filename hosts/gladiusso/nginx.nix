{pkgs, ...}: {
  services.nginx = {
    enable = true;
    package = pkgs.nginxStable.override {openssl = pkgs.libressl;};
    statusPage = true; # for Longview

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
    certs."gladiusso.com".extraDomainNames = ["music.gladiusso.com" "dev.gladiusso.com"];
  };
}
