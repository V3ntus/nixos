{
  lib,
  config,
  pkgs,
  options,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./programs.nix
    ./networking.nix
    ./nginx.nix

    ../../features/nixos/common

    ../../users/joe.nix
    ../../users/root.nix
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
    };
    listenAddresses = [
      {
        addr = "10.143.245.1";
        port = 22;
      }
    ];
  };

  services.endlessh-go = {
    enable = true;
    listenAddress = "172.232.31.102";
    port = 22;
    prometheus = {
      enable = true;
      listenAddress = "10.143.245.1";
    };
    extraOptions = [
      # "-geoip_supplier=ip-api"
    ];
  };

  systemd.services.endlessh-go.serviceConfig.ExecStart = let
    cfg = config.services.endlessh-go;
  in
    lib.mkForce (lib.concatStringsSep " " ([
        "${pkgs.endlessh-go}/bin/endlessh-go"
        "-logtostderr"
        "-host=${cfg.listenAddress}"
        "-port=${toString cfg.port}"
      ]
      ++ lib.optionals cfg.prometheus.enable [
        "-enable_prometheus"
        "-prometheus_host=${cfg.prometheus.listenAddress}"
        "-prometheus_port=${toString cfg.prometheus.port}"
      ]
      ++ cfg.extraOptions));

  services.longview = {
    enable = true;
    apiKeyFile = "/var/lib/longview/apiKeyFile";
    nginxStatusUrl = "http://localhost/nginx_status";
  };

  services.ntp.enable = true;
  networking.timeServers = options.networking.timeServers.default;

  system.stateVersion = "23.11";
}
