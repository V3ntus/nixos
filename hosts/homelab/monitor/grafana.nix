{
  pkgs,
  config,
  ...
}: let
  inventory = import ../inventory.nix;
  fqdn = "grafana.${inventory.domain}";
in {
  networking.firewall.allowedTCPPorts = [3000];

  sops.secrets = {
    "misc/smtp/password" = {
      mode = "0400";
      owner = "grafana";
      group = "grafana";
    };
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "0.0.0.0";
        http_port = 3000;
        domain = fqdn;
      };

      smtp = {
        enabled = true;
        host = "mail.privateemail.com:587";
        user = "joe@gladiusso.com";
        password = "$__file{${config.sops.secrets."misc/smtp/password".path}}";
        from_address = "grafana-noreply@gladiusso.com";
      };
    };
  };

  services.loki = {
    enable = true;
    configFile = ./loki-local-config.yaml;
  };
}
