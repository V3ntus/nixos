{config, ...}: {
  fileSystems = {
    "/mnt/Download" = {
      device = "files.gladiusso.com:/mnt/main/Download";
      fsType = "nfs";
    };
    "/mnt/Movies" = {
      device = "files.gladiusso.com:/mnt/main/Movies";
      fsType = "nfs";
    };
    "/mnt/TV" = {
      device = "files.gladiusso.com:/mnt/main/TV";
      fsType = "nfs";
    };
  };
}
