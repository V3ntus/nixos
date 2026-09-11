{
  networking.firewall.allowedTCPPorts = [3000];
  services.misskey = {
    enable = true;
    database = {
      createLocally = true;
    };
    redis = {
      createLocally = true;
    };
    settings = {
      url = "https://social.gladiusso.com";
    };
  };
}
