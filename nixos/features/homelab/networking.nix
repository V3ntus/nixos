{config, ...}: {
  networking = {
    networkmanager.enable = true;

    domain = config.homelab.domain;
    enableIPv6 = false;
  };
}
