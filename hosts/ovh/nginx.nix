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

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "blog" ];
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
    '';
  };

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
    blog-server = {
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      description = "blog NextJS server";
      path = ["/run/current-system/sw" pkgs.nodejs_24 pkgs.pnpm_11];
      serviceConfig = {
        Type = "exec";
        DynamicUser = true;
        Environment = "PORT=3003";
        WorkingDirectory = "/var/www/blog.gladiusso.com";
        ExecStart = "${pkgs.pnpm_11}/bin/pnpm run start";
        ReadWritePaths = [
          "/var/www/blog.gladiusso.com/public"
          "/var/www/blog.gladiusso.com/.next/cache/images"
        ];
      };
    };
  };

  services.nginx = nginxConfig;

  security.acme = import ../../features/snippets/nginx/conf/letsencrypt.nix {inherit config;};
}
