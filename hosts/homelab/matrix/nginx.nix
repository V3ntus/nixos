{config, pkgs, ...}: let
  baseUrl = "https://matrix.gladiusso.com";
  synapse-admin = pkgs.synapse-admin-etkecc.withConfig {
    restrictBaseUrl = [
      baseUrl
    ];
  };
in {
  networking.firewall.allowedTCPPorts = [80];

  users.users.nginx.extraGroups = [ "mastodon" ];

  services.nginx = {
    enable = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    upstreams = {
      mastodon_backend = {
        servers = {
          "unix:///run/mastodon-web/web.socket" = {
            fail_timeout = 0;
          };
        }; 
      };
      mastodon_streaming = {
        servers = {
          "127.0.0.1:4000" = {
            fail_timeout = 0;
          };
          "127.0.0.1:4001" = {
            fail_timeout = 0;
          };
          "127.0.0.1:4002" = {
            fail_timeout = 0;
          };
        };
        extraConfig = ''
          least_conn;
        '';
      };
    };
    virtualHosts = { 
      "admin.matrix.gladiusso.com" = {
        root = synapse-admin;
      };
      "_" = {
        default = true;
        root = "${config.services.mastodon.package}/public";
        locations = {
          "/" = {
            tryFiles = "$uri @mastodon";
          }; 
          "/system/" = {
            root = "/var/lib/mastodon/public-system";
          };
          "/api/v1/streaming/" = {
            proxyPass = "http://mastodon_streaming";
            extraConfig = ''
              proxy_buffering on;
              proxy_redirect off;

              tcp_nodelay on;
            '';
          };
          "@mastodon" = {
            proxyPass = "http://mastodon_backend";
            extraConfig = ''
              proxy_buffering on;
              proxy_redirect off;

              tcp_nodelay on;

              proxy_set_header X-Forwarded-Proto $http_x_forwarded_proto;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

              add_header X-Debug-Forwarded-Proto $http_x_forwarded_proto always;
              add_header X-Debug-Scheme $scheme always;
            '';
          };
        };
        extraConfig = ''
          keepalive_timeout 70;
          sendfile on;
          client_max_body_size 99m;
          proxy_read_timeout 120;

          gzip on;
          gzip_disable "msie6";
          gzip_vary on;
          gzip_proxied any;
          gzip_comp_level 6;
          gzip_buffers 16 8k;
          gzip_http_version 1.1;
          gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/rss+xml text/javascript image/svg+xml image/x-icon;
          gzip_static on; 

          error_page 404 500 501 502 503 504 /500.html;
        '';
      };
    };
  };
}
