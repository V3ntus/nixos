{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../features/home-manager/base.nix
    ../../features/home-manager/desktop/niri.nix
    ../../features/home-manager/desktop/hyprland.nix
    ../../features/home-manager/desktop/addons/wlsunset.nix
    ../../features/home-manager/desktop/addons/wofi.nix
    ../../features/home-manager/terminal/kitty.nix
    ../../features/home-manager/terminal/nvim.nix
    ../../features/home-manager/terminal/ohmyzsh.nix
  ];

  home.username = "joe";
  home.homeDirectory = "/home/joe";

  home.packages = with pkgs; [
    teams-for-linux
    httpie
    postman
    remmina
    dbeaver-bin
  ];

  wayland.windowManager.hyprland.settings = {
    env = [
      "LIBVA_DRIVER_TYPE,nvidia"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    ];

    monitor = lib.mkForce [
      "DP-5, 2560x1440@143.97, 2560x0, 1"
      "HDMI-A-1, 2560x1440@143.97, 0x0, 1"
      "eDP-1, 1920x1080@60, 5120x720, 1"
    ];
  };

  programs.niri.settings.outputs = lib.mkForce {
    "DP-5" = {
      enable = true;
      mode = {
        width = 2560;
        height = 1440;
        refresh = 143.97;
      };
      position = {
        x = 0;
        y = 0;
      };
      scale = 1.0;
    };

    "HDMI-A-1" = {
      enable = true;
      mode = {
        width = 2560;
        height = 1440;
        refresh = 143.97;
      };
      position = {
        x = 2560;
        y = 0;
      };
      scale = 1.0;
    };

    "eDP-1" = {
      enable = true;
      mode = {
        width = 1920;
        height = 1080;
        refresh = 60.0;
      };
      position = {
        x = 5120;
        y = 720;
      };
      scale = 1.0;
    };
  };
}
