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

    ../../features/nixos/common/hardware.nix
    ../../features/nixos/common/locale.nix
    ../../features/nixos/common/nix.nix
    ../../features/nixos/common/security.nix
    ../../features/nixos/common/sops.nix

    ../../users/joe.nix
    ../../users/root.nix
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    listenAddresses = [
      {
        addr = "10.143.245.1";
        port = 22;
      }
      {
        addr = "172.232.31.102";
        port = 993;
      }
    ];
    extraConfig = ''
      Match Address 10.143.245.3
        PermitRootLogin without-password
    '';
    banner = ''
       ________  ________  ___   ___  ________
      |\   ____\|\   ____\|\  \ |\  \|\   __  \
      \ \  \___|\ \  \___|\ \  \\_\  \ \  \|\  \
       \ \  \    \ \_____  \ \______  \ \  \\\  \
        \ \  \____\|____|\  \|_____|\  \ \  \\\  \
         \ \_______\____\_\  \     \ \__\ \_______\
          \|_______|\_________\     \|__|\|_______|
                   \|_________|

      ----------------------------------------------

      Unauthorized use of this system is prohibited.
            All network activity is monitored.

      ----------------------------------------------
    '';
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
