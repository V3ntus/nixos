{options, ...}: let
  consts = import ./consts.nix;
in {
  imports = [
    ./hardware-configuration.nix
    ./programs.nix
    ./networking.nix
    ./fail2ban.nix
    ./pangolin.nix
    ./nginx.nix

    ../../features/nixos/common/hardware.nix
    ../../features/nixos/common/locale.nix
    ../../features/nixos/common/nix.nix
    ../../features/nixos/common/security.nix
    ../../features/nixos/common/sops.nix

    ../../users/root.nix
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "without-password";
      PasswordAuthentication = false;
      Banner = ../../features/nixos/terminal/banner.txt;
    };
    listenAddresses = [
      {
        addr = consts.ipv4;
        port = 8080;
      }
      {
        addr = "10.143.245.1";
        port = 22;
      }
    ];
  };

  services.endlessh-go = {
    enable = true;
    listenAddress = consts.ipv4;
    port = 22;
    prometheus = {
      enable = true;
      listenAddress = "10.143.245.1";
    };
    extraOptions = [
      "-geoip_supplier=ip-api"
    ];
  };

  services.prometheus.exporters.node = {
    enable = true;
    port = 9000;
    listenAddress = "10.143.245.1";
    enabledCollectors = (import ../homelab/prometheus_exporter.nix).services.prometheus.exporters.node.enabledCollectors;
  };

  services.ntp.enable = true;
  networking.timeServers = options.networking.timeServers.default;

  services.logrotate.checkConfig = false;

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  system.stateVersion = "23.11";
}
