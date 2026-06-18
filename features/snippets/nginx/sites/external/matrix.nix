{config, ...}: let
  u = import ../_util.nix;
  matrix = import ../../conf/matrix.nix;
in
  u.base {
    internal = false;
    locations = {
      "/" = {
        root = "/var/www/matrix.gladiusso.com";
      };
      "/_matrix" = {
        proxyPass = "http://${u.inventory.hosts.matrix.ip}:8008";
        extraConfig = matrix.matrixExtraConfig;
      };
      "/_matrix/maubot/" = {
        proxyPass = "http://${u.inventory.hosts.matrix.ip}:${toString config.services.maubot.settings.server.port}";
        proxyWebsockets = true;
      };
      "/_synapse/admin" = {
        proxyPass = "http://${u.inventory.hosts.matrix.ip}:8008";
        extraConfig = matrix.matrixExtraConfig;
      };
      "/_synapse/client" = {
        proxyPass = "http://${u.inventory.hosts.matrix.ip}:8008";
        extraConfig = matrix.matrixExtraConfig;
      };
      "^~ /livekit/jwt/" = {
        priority = 400;
        proxyPass = "http://${u.inventory.hosts.matrix.ip}:${toString config.services.lk-jwt-service.port}/";
      };
      "^~ /livekit/sfu/" = {
        extraConfig = ''
          proxy_send_timeout 120;
          proxy_read_timeout 120;
          proxy_buffering off;

          proxy_set_header Accept-Encoding gzip;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
        '';
        priority = 400;
        proxyPass = "http://${u.inventory.hosts.matrix.ip}:${toString config.services.livekit.settings.port}/";
        proxyWebsockets = true;
      };
      "= /.well-known/matrix/server".extraConfig = matrix.mkWellKnown matrix.serverConfig;
      "= /.well-known/matrix/client".extraConfig = matrix.mkWellKnown matrix.clientConfig;
    };
  }
