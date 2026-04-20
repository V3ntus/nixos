{
  pkgs,
  config,
  ...
}: let
  inventory = import ../inventory.nix;
  blackboxPort = builtins.toString config.services.prometheus.exporters.blackbox.port;
  nodeTarget = host: port: {
    targets = ["${inventory.hosts.${host}.ip}:${toString port}"];
    labels = {
      hostname = "${host}.${inventory.domain}";
    };
  };
in {
  security.pki.certificateFiles = [../../../certs/root_ca.crt];
  services.prometheus = {
    enable = true;
    globalConfig = {
      scrape_interval = "10s";
    };
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          (nodeTarget "ai" 9000)
          (nodeTarget "apps" 9000)
          (nodeTarget "arr" 9000)
          (nodeTarget "matrix" 9000)
          (nodeTarget "net" 9000)
          (nodeTarget "nix" 9000)
          (nodeTarget "vps" 9000)
        ];
      }
      {
        job_name = "blackbox";
        metrics_path = "/metrics";
        static_configs = [
          {
            targets = ["localhost:${blackboxPort}"];
          }
        ];
      }
      {
        job_name = "blackbox-probe";
        metrics_path = "/probe";
        params.module = ["http_2xx"];
        static_configs = [
          {
            targets =
              (builtins.map (host: "https://${host}.${inventory.domain}") (builtins.attrNames inventory.vhosts))
              ++ [
                "https://ca.gladiusso.com/health"
              ];
          }
        ];
        relabel_configs = [
          {
            source_labels = ["__address__"];
            target_label = "__param_target";
          }
          {
            source_labels = ["__param_target"];
            target_label = "instance";
          }
          {
            target_label = "__address__";
            replacement = "localhost:${blackboxPort}";
          }
        ];
      }
    ];
    exporters = {
      blackbox = {
        enable = true;
        configFile = pkgs.writers.writeYAML "blackbox-config.yaml" {
          modules = {
            http_2xx = {
              prober = "http";
              http = {
                method = "GET";
              };
            };
          };
        };
      };
    };
  };
}
