{pkgs, ...}: {
  services.radarr = {
    enable = true;
    openFirewall = true;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  services.lidarr = {
    enable = true;
    openFirewall = true;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.flaresolverr = {
    enable = false; # not working because of selenium/chromium 127+
    openFirewall = true;
  };

  systemd.services = {
    radarr = {
      after = ["mnt-Download.mount" "mnt-Movies.mount"];
      wants = ["mnt-Download.mount" "mnt-Movies.mount"];
    };

    sonarr = {
      after = ["mnt-Download.mount" "mnt-TV.mount"];
      wants = ["mnt-Download.mount" "mnt-TV.mount"];
    };

    lidarr = {
      after = ["mnt-Download.mount" "mnt-Music.mount"];
      wants = ["mnt-Download.mount" "mnt-Music.mount"];
    };
  };
}
