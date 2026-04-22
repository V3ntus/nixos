{pkgs, ...}: let
  baseUrl = "https://matrix.gladiusso.com";
  client_config."m.homeserver".base_url = baseUrl;
  synapse-admin = pkgs.synapse-admin-etkecc.withConfig {
    restrictBaseUrl = [
      baseUrl
    ];
  };
in {
  networking.firewall.allowedTCPPorts = [80];
  services.nginx = {
    enable = true;
    virtualHosts = {
      "element.matrix.gladiusso.com" = {
        default = true;
        root = pkgs.element-web.override {
          conf = {
            default_server_config = client_config;
          };
        };
      };
      "admin.matrix.gladiusso.com" = {
        root = synapse-admin;
      };
    };
  };
}
