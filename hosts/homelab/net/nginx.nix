{
  pkgs,
  config,
  ...
}: let
  nginxConfig = import ../../../features/snippets/nginx {
    virtualHosts =
      (import ../../../features/snippets/nginx/sites/internal {inherit pkgs config;})
      // {
        "proxmox.gladiusso.com" = import ../../../features/snippets/nginx/sites/proxmox.nix;
      };
  };
in {
  networking.firewall.allowedTCPPorts = [80 443];

  users.users.nginx.extraGroups = ["acme"];

  services.nginx = nginxConfig;

  security.acme = import ../../../features/snippets/nginx/conf/step_ca.nix {virtualHosts = nginxConfig.virtualHosts;};
}
