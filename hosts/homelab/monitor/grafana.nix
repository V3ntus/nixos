let
  inventory = import ../inventory.nix;
  fqdn = "grafana.${inventory.domain}";
in {
  networking.firewall.allowedTCPPorts = [ 3000 ];
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "0.0.0.0";
        http_port = 3000;
        domain = fqdn;
      };
    };
  };
}
