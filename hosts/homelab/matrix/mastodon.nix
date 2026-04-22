{config, ...}: let
  inventory = import ../inventory.nix;
in {
  sops.secrets."misc/smtp/password" = {
    mode = "0400";
    owner = config.services.mastodon.user;
    group = config.services.mastodon.group;
  };

  services.mastodon = {
    enable = true;
    localDomain = "m.gladiusso.com";
    configureNginx = false;
    streamingProcesses = 3;
    smtp = {
      host = "mail.privateemail.com";
      user = "joe@gladiusso.com";
      passwordFile = config.sops.secrets."misc/smtp/password".path;
      fromAddress = "mastodon-noreply@gladiusso.com";
    };
    trustedProxy = "127.0.0.1/32,::1";
    extraConfig = {
      SINGLE_USER_MODE = "true";
      ALLOWED_PRIVATE_ADDRESSES = "127.0.0.1,192.168.2.0/24";
      TRUSTED_PROXY_IP = "127.0.0.1/32,::1";
      FORCE_SSL = "false";
    }; 
  };
}
