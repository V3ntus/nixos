{
  pkgs,
  lib,
  config,
  ...
}: let
  fqdn = "matrix.gladiusso.com";
  baseUrl = "https://${fqdn}";
  livekitKeyFile = "/run/livekit.key";
in {
  users.groups."matrix-coturn" = {
    members = [
      "matrix-synapse"
      "turnserver"
    ];
  };

  sops.secrets = {
    "matrix/coturn/static_auth_secret" = {
      sopsFile = ../../../users/secrets.yaml;
      mode = "440";
      group = "matrix-coturn";
    };
    "matrix/registration_shared_secret" = {
      sopsFile = ../../../users/secrets.yaml;
      mode = "400";
      owner = "matrix-synapse";
    };
    "matrix/draupnir/access_token" = {
      sopsFile = ../../../users/secrets.yaml;
      mode = "444";
    };
  };

  services.coturn = {
    enable = true;
    no-cli = true;
    no-tcp-relay = true;
    min-port = 49000;
    max-port = 50000;
    use-auth-secret = true;
    static-auth-secret-file = config.sops.secrets."matrix/coturn/static_auth_secret".path;
    realm = fqdn;
    cert = "/etc/coturn/full.pem";
    pkey = "/etc/coturn/key.pem";
    extraConfig = ''
      external-ip=172.232.31.102/192.168.2.20
      no-multicast-peers
      denied-peer-ip=0.0.0.0-0.255.255.255
      denied-peer-ip=10.0.0.0-10.255.255.255
      denied-peer-ip=100.64.0.0-100.127.255.255
      denied-peer-ip=127.0.0.0-127.255.255.255
      denied-peer-ip=169.254.0.0-169.254.255.255
      denied-peer-ip=172.16.0.0-172.31.255.255
      denied-peer-ip=192.0.0.0-192.0.0.255
      denied-peer-ip=192.0.2.0-192.0.2.255
      denied-peer-ip=192.88.99.0-192.88.99.255
      denied-peer-ip=192.168.0.0-192.168.255.255
      denied-peer-ip=198.18.0.0-198.19.255.255
      denied-peer-ip=198.51.100.0-198.51.100.255
      denied-peer-ip=203.0.113.0-203.0.113.255
      denied-peer-ip=240.0.0.0-255.255.255.255
      denied-peer-ip=::1
      denied-peer-ip=64:ff9b::-64:ff9b::ffff:ffff
      denied-peer-ip=::ffff:0.0.0.0-::ffff:255.255.255.255
      denied-peer-ip=100::-100::ffff:ffff:ffff:ffff
      denied-peer-ip=2001::-2001:1ff:ffff:ffff:ffff:ffff:ffff:ffff
      denied-peer-ip=2002::-2002:ffff:ffff:ffff:ffff:ffff:ffff:ffff
      denied-peer-ip=fc00::-fdff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
      denied-peer-ip=fe80::-febf:ffff:ffff:ffff:ffff:ffff:ffff:ffff
    '';
  };

  services.livekit = {
    enable = true;
    openFirewall = true;
    settings = {
      room = {
        auto_create = false;
      };
    };
    keyFile = livekitKeyFile;
  };

  services.lk-jwt-service = {
    enable = true;
    livekitUrl = "wss://${fqdn}/livekit/sfu";
    keyFile = livekitKeyFile;
  };

  systemd.services.livekit-key = {
    before = ["lk-jwt-service.service" "livekit.service"];
    wantedBy = ["multi-user.target"];
    path = with pkgs; [livekit coreutils gawk];
    script = ''
      echo "Key missing, generating key..."
      echo "lk-jwt-service: $(livekit-server generate-keys | tail -1 | awk '{print $3}')" > "${livekitKeyFile}"
    '';
    serviceConfig.Type = "oneshot";
    unitConfig.ConditionPathExists = "!${livekitKeyFile}";
  };

  services.draupnir = {
    enable = true;
    settings = {
      homeserverUrl = baseUrl;
      managementRoom = "!CnmZjzBgOVQTaWadXG:${fqdn}";
    };
    secrets = {
      accessToken = config.sops.secrets."matrix/draupnir/access_token".path;
    };
  };

  systemd.services.lk-jwt-service.environment.LIVEKIT_FULL_ACCESS_HOMESERVERS = fqdn;

  services.matrix-synapse = {
    enable = true;
    settings = {
      enable_registration = true;
      registration_requires_token = true;
      server_name = config.networking.fqdn;
      public_baseurl = baseUrl;
      listeners = [
        {
          port = 8008;
          bind_addresses = ["::1" "0.0.0.0"];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [
                "client"
                "federation"
              ];
              compress = true;
            }
          ];
        }
      ];
      turn_uris = ["turn:${fqdn}:3478?transport=udp" "turn:${fqdn}:3478?transport=tcp"];
      turn_user_lifetime = "1h";
    };
    extraConfigFiles = [
      config.sops.templates."matrix-synapse-secrets.yaml".path
    ];
  };

  sops.templates."matrix-synapse-secrets.yaml" = {
    mode = "444";
    content = ''
      turn_shared_secret: ${config.sops.placeholder."matrix/coturn/static_auth_secret"}
      registration_shared_secret: ${config.sops.placeholder."matrix/registration_shared_secret"}
    '';
  };

  networking.firewall = let
    range = with config.services.coturn;
    with config.services.livekit.settings.rtc; [
      {
        from = min-port;
        to = max-port;
      }
      {
        from = port_range_start;
        to = port_range_end;
      }
    ];
  in {
    allowedUDPPortRanges = range;
    allowedUDPPorts = [3478 5349];
    allowedTCPPortRanges = [];
    allowedTCPPorts = [3478 5349 8008 config.services.lk-jwt-service.port];
  };
}
