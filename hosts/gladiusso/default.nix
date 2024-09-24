{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./programs.nix
    ./networking.nix
    ./nginx.nix
    ./wireguard.nix

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
        addr = "172.232.31.102"; # 10.143.245.1
        port = 22;
      }
    ];
  };

  services.endlessh-go = {
    enable = false;
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

  system.stateVersion = "23.11";

  # sops.secrets = {
  #   "wireguard/joe-work/privkey" = { sopsFile = ../../users/secrets.yaml; };
  # };

  # networking.wg-quick.interfaces.wg0.address = [ "10.143.245.4/24" "fd11:5ee:bad:c0de::4/64" ];
  # networking.wg-quick.interfaces.wg0.dns = [ "192.168.2.6" "9.9.9.9" ];
  # networking.wg-quick.interfaces.wg0.privateKeyFile = config.sops.secrets."wireguard/joe-work/privkey".path;
}
