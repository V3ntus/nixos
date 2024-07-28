{config, ...}: {
  fileSystems."/mnt/Download" = {
    device = "files.gladiusso.com:/mnt/main/Download";
    fsType = "nfs";
  };
}
