{
  fileSystems = {
    "/mnt/Pictures" = {
      device = "files.gladiusso.com:/mnt/main/Pictures";
      fsType = "nfs";
    };
  };

  # Deterministic gid/uid for immich
  users.groups.immich = {
    name = "immich";
    gid = 2999;
  };

  users.users.immich = {
    name = "immich";
    uid = 2999;
    group = "immich";
    isSystemUser = true;
  };

  services.immich = {
    enable = false; # NixOS 25 marked this as insecure
    host = "0.0.0.0";
    openFirewall = true;
    mediaLocation = "/mnt/Pictures";
  };
}
