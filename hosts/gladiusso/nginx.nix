{
  pkgs,
  config,
  ...
}: let
  nginxConfig = import ../../features/snippets/nginx {
    virtualHosts =
      (import ../../features/snippets/nginx/sites/external {inherit pkgs config;})
      // {
        "proxmox.gladiusso.com" =
          import ../../features/snippets/nginx/sites/proxmox.nix
          // {
            useACMEHost = null;
            enableACME = true;
          };
      };
  };
in {
  sops.secrets."matrix/cert_sync_key" = {
    sopsFile = ../../users/secrets.yaml;
  };

  users.users.nginx.extraGroups = ["acme"];

  systemd.services = {
    wedding-server = {
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      description = "wedding NextJS server";
      path = ["/run/current-system/sw" pkgs.nodejs_24];
      serviceConfig = {
        Type = "exec";
        DynamicUser = true;
        Environment = "PORT=3001";
        WorkingDirectory = "/var/www/wedding.gladiusso.com";
        ExecStart = "${pkgs.nodejs_24}/bin/npm run start";
      };
    };
    dev-server = {
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      description = "dev NextJS server";
      path = ["/run/current-system/sw" pkgs.nodejs_24];
      serviceConfig = {
        Type = "exec";
        DynamicUser = true;
        Environment = "PORT=3002";
        WorkingDirectory = "/var/www/dev.gladiusso.com";
        ExecStart = "${pkgs.nodejs_24}/bin/npm run start";
      };
    };
  };

  services.nginx = nginxConfig;

  security.acme = import ../../features/snippets/nginx/conf/letsencrypt.nix {inherit config;};
}
