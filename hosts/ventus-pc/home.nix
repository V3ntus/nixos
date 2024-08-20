{pkgs, ...}: {
  imports = [
    ../../features/home-manager/base.nix
    ../../features/home-manager/desktop/hyprland.nix
    ../../features/home-manager/desktop/niri.nix
    ../../features/home-manager/desktop/addons/swaync.nix
    ../../features/home-manager/desktop/addons/wlsunset.nix
    ../../features/home-manager/desktop/addons/wofi.nix
    ../../features/home-manager/terminal/kitty.nix
    ../../features/home-manager/terminal/nvim.nix
    ../../features/home-manager/terminal/ohmyzsh.nix
  ];

  home.username = "joe";
  home.homeDirectory = "/home/joe";

  home.packages = with pkgs; [
    alsa-scarlett-gui
    teams-for-linux
    tidal-hifi
  ];

  programs.niri.settings.outputs = {
    "DP-4" = {
      enable = true;
      mode = {
        width = 3440;
        height = 1440;
        refresh = 165.0;
      };
      variable-refresh-rate = true;
    };
  };
}
