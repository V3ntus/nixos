{config, ...}: let
  consts = import ./consts.nix;
in {
  services.pangolin = {
    enable = false;
    settings = {
      flags = {
        disable_signup_without_invite = true;
        disable_user_create_org = true;
        require_email_verification = true;
        disable_enterprise_features = true;
      };

      email = {
        smtp_host = "mail.privateemail.com";
        smtp_port = 465;
        smtp_user = "joe@gladiusso.com";
        smtp_secure = true;
        no_reply = "pangolin-noreply@gladiusso.com";
      };
    };
    baseDomain = "gladiusso.com";
    dashboardDomain = "pangolin.gladiusso.com";
    letsEncryptEmail = "joe@gladiusso.com";
    openFirewall = true;
    environmentFile = config.sops.secrets."pangolin".path;
  };

  #sops.secrets."pangolin" = {
  #  mode = "0600";
  #  owner = "pangolin";
  #  group = "fossorial";
  #};
}
