{
  pkgs,
  config,
  ...
}: let
  inventory = import ../homelab/inventory.nix;
  matrixFqdn = "matrix.gladiusso.com";
  baseUrl = "https://${matrixFqdn}";
  clientConfig = {
    "m.homeserver".base_url = baseUrl;
    # "m.identity_server".base_url = baseUrl;
    "org.matrix.msc3575.proxy".url = baseUrl;
    "org.matrix.msc4143.rtc_foci" = [
      {
        type = "livekit";
        livekit_service_url = "${baseUrl}/livekit/jwt";
      }
    ];
  };
  serverConfig."m.server" = "${matrixFqdn}:443";
  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';

  matrixExtraConfig = ''
      proxy_set_header X-Forwarded-For $remote_addr;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_set_header Host $host;
      proxy_hide_header Access-Control-Allow-Origin;

      client_max_body_size 50M;

      add_header 'Access-Control-Allow-Origin' '*' always;
      add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
      add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type' always;
      if ($request_method = 'OPTIONS') {
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type';
        add_header 'Content-Length' '0';
        return 204;
    }
  '';
in {
  sops.secrets."matrix/cert_sync_key" = {
    sopsFile = ../../users/secrets.yaml;
  };

  systemd.services.wedding-server = {
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    description = "wedding NextJS server";
    path = ["/run/current-system/sw" pkgs.nodejs_24];
    serviceConfig = {
      Type = "exec";
      DynamicUser = true;
      Environment = "PORT=3001";
      WorkingDirectory = "/var/www/wedding.gladiusso.com";
      ExecStart = ''${pkgs.nodejs_24}/bin/npm run start'';
    };
  };

  systemd.services.dev_gladiusso_com-server = {
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    description = "dev.gladiusso.com NextJS server";
    path = ["/run/current-system/sw" pkgs.nodejs_24];
    serviceConfig = {
      Type = "exec";
      DynamicUser = true;
      Environment = "PORT=3002";
      WorkingDirectory = "/var/www/dev.gladiusso.com";
      ExecStart = ''${pkgs.nodejs_24}/bin/npm run start'';
    };
  };

  services.nginx = {
    enable = true;
    package = pkgs.nginxStable.override {openssl = pkgs.libressl;};
    statusPage = true; # for Longview
    recommendedProxySettings = true;

    virtualHosts = {
      "gladiusso.com" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/gladiusso.com";
      };

      "music.gladiusso.com" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/music.gladiusso.com";
        locations."/pages/" = {
          tryFiles = "$uri $uri.html";
        };
      };

      "dev.gladiusso.com" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:3002";
          extraConfig = ''
            # include ${./nginx/authelia-authrequest.conf};
          '';
        };
        extraConfig = ''
          # include ${./nginx/authelia-location.conf};
        '';
      };

      "jump.gladiusso.com" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://${inventory.hosts.net.ip}:8182";
          proxyWebsockets = true;
          extraConfig = ''
            include ${./nginx/authelia-authrequest.conf};
            proxy_read_timeout 300;
          '';
        };
        extraConfig = ''
          include ${./nginx/authelia-location.conf};
        '';
      };

      "mc.gladiusso.com" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://192.168.2.11:8100";
        };
      };

      "wedding.gladiusso.com" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:3001";
        };
      };

      "element.gladiusso.com" = {
        forceSSL = true;
        enableACME = true;
        root = pkgs.element-web.override {
          conf = {
            default_server_config = clientConfig;
            default_theme = "dark";
            disable_guests = true;
            integrations_ui_url = "https://scalar.vector.im/";
            integrations_rest_url = "https://scalar.vector.im/api";
            integrations_widgets_urls = [
              "https://scalar.vector.im/_matrix/integrations/v1"
              "https://scalar.vector.im/api"
              "https://scalar-staging.vector.im/_matrix/integrations/v1"
              "https://scalar-staging.vector.im/api"
            ];
          };
        };
      };

      "cinny.gladiusso.com" = {
        forceSSL = true;
        enableACME = true;
        root = pkgs.cinny;
      };

      "matrix.gladiusso.com" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            root = "/var/www/matrix.gladiusso.com";
          };
          "/_matrix" = {
            proxyPass = "http://192.168.2.20:8008";
            extraConfig = matrixExtraConfig;
          };
          "/_matrix/maubot/" = {
            proxyPass = "http://192.168.2.20:${toString config.services.maubot.settings.server.port}";
            proxyWebsockets = true;
          };
          "/_synapse/admin" = {
            proxyPass = "http://192.168.2.20:8008";
            extraConfig = matrixExtraConfig;
          };
          "/_synapse/client" = {
            proxyPass = "http://192.168.2.20:8008";
            extraConfig = matrixExtraConfig;
          };
          "^~ /livekit/jwt/" = {
            priority = 400;
            proxyPass = "http://192.168.2.20:${toString config.services.lk-jwt-service.port}/";
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
            proxyPass = "http://192.168.2.20:${toString config.services.livekit.settings.port}/";
            proxyWebsockets = true;
          };
          "= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
          "= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
        };
      };

      "auth.gladiusso.com" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://${inventory.hosts.net.ip}:9091";
            extraConfig = ''
              include ${./nginx/proxy.conf};
            '';
          };
          "/api/verify" = {
            proxyPass = "http://${inventory.hosts.net.ip}:9091";
          };
          "/api/authz/" = {
            proxyPass = "http://${inventory.hosts.net.ip}:9091";
          };
        };
      };

      "backthehox.com" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/backthehox";
      };

      "thejoalition.org" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/thejoalition.org";
      };
    };

    appendHttpConfig = ''
      map $http_user_agent $bad_bot {
          default 0;
          ~*(curl|(W|w)get|scrapy|bot|Go-http-client) 1;
      }

      server {
          if ($bad_bot) {
              return 403;
          }
      }
    '';
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "joe@gladiusso.com";
    certs."gladiusso.com" = {
      extraDomainNames = [
        "music.gladiusso.com"
        "dev.gladiusso.com"
        "mc.gladiusso.com"
        "matrix.gladiusso.com"
        "element.gladiusso.com"
        "cinny.gladiusso.com"
        "jump.gladiusso.com"
        "bsky.gladiusso.com"
      ];
      postRun = ''
        cat /var/lib/acme/gladiusso.com/key.pem | ssh -i ${config.sops.secrets."matrix/cert_sync_key".path} certsync@192.168.2.20 "deploy_cert -pkey"
        cat /var/lib/acme/gladiusso.com/key.pem | ssh -i ${config.sops.secrets."matrix/cert_sync_key".path} certsync@192.168.2.20 "deploy_cert -cert"
      '';
    };
  };
}
