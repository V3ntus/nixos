{pkgs, config, ...}: rec {
  sops.secrets = {
    "authelia/jwtSecret" = {
      mode = "0400";
      owner = config.services.authelia.instances."default".user;
      group = config.services.authelia.instances."default".group;
    };
    "authelia/storageEncryptionKey" = {
      mode = "0400";
      owner = config.services.authelia.instances."default".user;
      group = config.services.authelia.instances."default".group;
    };
    "authelia/sessionSecret" = {
      mode = "0400";
      owner = config.services.authelia.instances."default".user;
      group = config.services.authelia.instances."default".group;
    };
    "misc/smtp/password" = {
      mode = "0400";
      owner = config.services.authelia.instances."default".user;
      group = config.services.authelia.instances."default".group;
    };
  };

  sops.templates."authelia-smtp-secret.yaml" = {
    mode = "0400";
    owner = config.services.authelia.instances."default".user;
    group = config.services.authelia.instances."default".group;
    content = ''
      notifier:
        smtp:
          password: ${config.sops.placeholder."misc/smtp/password"}
    '';
  };

  networking.firewall.allowedTCPPorts = [
    9091
  ];

  services.authelia.instances = {
    "default" = {
      enable = true;
      settings = {
        authentication_backend = {
          file = {
            path = ./users.yaml;
          };
        };

        storage.postgres = {
          address = "unix:///run/postgresql/";
          database = "authelia";
          username = "authelia";
        };

        session = {
          cookies = [
            {
              domain = "gladiusso.com";
              authelia_url = "https://auth.gladiusso.com";
            }
          ];
        };

        notifier = {
          disable_startup_check = false;
          smtp = {
            address = "smtp://mail.privateemail.com:587";
            username = "joe@gladiusso.com";
            sender = "CS30 Authelia <auth-noreply@gladiusso.com>";
            subject = "CS30 - {title}";
          };
        };

        access_control = {
          default_policy = "deny";
          rules = [
            {
              domain = "*.gladiusso.com";
              policy = "one_factor";
            }
          ];
        };

        server.endpoints.authz.auth-request = {
          implementation = "AuthRequest";
        };
      };
      settingsFiles = [
        config.sops.templates."authelia-smtp-secret.yaml".path
      ];
      secrets = {
        jwtSecretFile = config.sops.secrets."authelia/jwtSecret".path;
        storageEncryptionKeyFile = config.sops.secrets."authelia/storageEncryptionKey".path;
        sessionSecretFile = config.sops.secrets."authelia/sessionSecret".path;
      };
    };
  };

  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
    '';
    initialScript = pkgs.writeText "initial.sql" ''
      CREATE ROLE "authelia";
      ALTER ROLE "authelia" WITH LOGIN;
      CREATE DATABASE "authelia" WITH OWNER "authelia";
    '';
  };
}
