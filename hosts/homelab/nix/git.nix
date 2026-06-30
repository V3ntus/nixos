{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in {
  sops.secrets = {
    "misc/smtp/password" = {
      mode = "0400";
      owner = "forgejo";
      group = "forgejo";
    };
    "misc/forgejo/password" = {
      owner = "forgejo";
    };
  };

  systemd.services.forgejo.preStart = let
    adminCmd = "${lib.getExe cfg.package} admin user";
    pwd = config.sops.secrets."misc/forgejo/password";
    user = "joe";
  in ''
    ${adminCmd} create --admin --email "joe@gladiusso.com" --username ${user} --password "$(tr -d '\n' < ${pwd.path})" || true
  '';

  services.forgejo = {
    enable = true;
    database.type = "postgres";

    lfs.enable = true;

    settings = {
      server = {
        DOMAIN = "git.gladiusso.com";
        ROOT_URL = "https://${srv.DOMAIN}/";
        HTTP_PORT = 3000;
        SSH_PORT = lib.head config.services.openssh.ports;
        DISABLE_SSH = true;
      };

      service = {
        DISABLE_REGISTRATION = false;
        REGISTER_MANUAL_CONFIRM = true;
      };

      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };

      mailer = {
        ENABLED = true;
        SMTP_ADDR = "mail.privateemail.com";
        SMTP_PORT = 465;
        FROM = "forgejo-noreply@gladiusso.com";
        USER = "joe@gladiusso.com";
      };
    };

    secrets = {
      mailer.PASSWD = config.sops.secrets."misc/smtp/password".path;
    };
  };

  networking.firewall.allowedTCPPorts = [3000];
}
