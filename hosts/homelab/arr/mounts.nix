{config, ...}: {
  fileSystems."/mnt/Download" = {
    device = "files.gladiusso.com:/Download";
    fsType = "nfs";
    options = [
      "rw"
      "uid=${builtins.toString config.users.users.transmission.uid}"
      "gid=${builtins.toString config.users.groups.transmission.gid}"
    ];
  };
}
