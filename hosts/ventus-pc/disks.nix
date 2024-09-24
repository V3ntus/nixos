{
  fileSystems = {
    "/mnt/games1" = {
      device = "/dev/disk/by-partuuid/48ae5881-4e3e-4d61-91a2-20d0501c8b49";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000" "noauto" "x-systemd.automount"];
    };
    "/mnt/games2" = {
      device = "/dev/disk/by-partuuid/e4ddd76b-8c90-4949-9890-bdc8f7e4af8e";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000" "noauto" "x-systemd.automount"];
    };
    "/mnt/games3" = {
      device = "/dev/disk/by-partuuid/fd60ca48-94b5-4fb6-ac2a-d53759b11339";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000" "noauto" "x-systemd.automount"];
    };
  };
}
