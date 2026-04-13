let
  inventory = import ../inventory.nix;
  target = host: port: {
    targets = [ "${inventory.hosts.${host}.ip}:${toString port}" ];
    labels = {
      hostname = "${host}.gladiusso.com";
    };
  };
in {
  services.prometheus = {
    enable = true;
    globalConfig = {
      scrape_interval = "10s";
    };
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          (target "ai" 9000)
          (target "apps" 9000)
          (target "arr" 9000)
          (target "matrix" 9000)
          (target "net" 9000)
          (target "nix" 9000)
        ];
      }
    ];
  };
}
