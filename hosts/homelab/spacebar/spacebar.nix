{
  lib,
  pkgs,
  spacebar_server,
  ...
}: let
  server = lib.getExe spacebar_server.packages.x86_64-linux.default;
  config = builtins.toJSON {
    general = {
      instanceName = "CS40";
      instanceDescription = "CS40 Spacebar Instance hosted by V3ntus";
      serverName = "spacebar.gladiusso.com";
    };

    api = {
      endpointPublic = "https://spacebar.gladiusso.com/api/v9";
    };

    cdn = {
      endpointPublic = "https://spacebar.gladiusso.com";
      endpointPrivate = "http://localhost:3001";
    };

    gateway = {
      endpointPublic = "ws://spacebar.gladiusso.com";
    };

    limits = {
      rate = {
        enabled = true;
      };
    };

    security = {
      autoUpdate = false;
    };

    register = {
      disabled = true;
    };
  };
in {
  system.activationScripts.writeSpacebarConfig = ''
    if [[ ! -e /etc/spacebar.json ]]; then
      echo '${config}' > /etc/spacebar.json
    fi
  '';

  systemd.services.spacebar_server = {
    wants = ["postgresql.service"];
    after = ["postgresql.service"];
    environment = {
      DATABASE = "postgres://postgres@/spacebar?host=/run/postgresql/";
      CONFIG_PATH = "/etc/spacebar.json";
    };

    serviceConfig = {
      ExecStart = "${server}";
      Restart = "on-failure";
      RestartSec = "5s";

      DynamicUser = true;
      PrivateTmp = true;
      NoNewPrivileges = true;
    };
  };
}
