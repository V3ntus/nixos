{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--password-store=gnome-libsecret"
    ];
  };
}
