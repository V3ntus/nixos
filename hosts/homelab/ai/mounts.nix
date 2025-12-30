{
  systemd.services."jellyfin" = {
    after = ["mnt-Movies.mount" "mnt-TV.mount" "mnt-Music.mount"];
    wants = ["mnt-Movies.mount" "mnt-TV.mount" "mnt-Music.mount"];
  };

  fileSystems = {
    "/mnt/Download" = {
      device = "files.gladiusso.com:/mnt/main/Download";
      fsType = "nfs";
    };
    "/mnt/Movies" = {
      device = "files.gladiusso.com:/mnt/main/Movies";
      fsType = "nfs";
      options = ["noatime" "nodiratime"];
    };
    "/mnt/TV" = {
      device = "files.gladiusso.com:/mnt/main/TV";
      fsType = "nfs";
    };
    "/mnt/Music" = {
      device = "files.gladiusso.com:/mnt/main/Music";
      fsType = "nfs";
    };
  };
}
