{pkgs, ...}: {
  imports = [
    ../../features/home-manager/base.nix
    # ../../features/home-manager/desktop/hyprland.nix
    # ../../features/home-manager/desktop/niri.nix
    # ../../features/home-manager/desktop/addons/swaync.nix
    # ../../features/home-manager/desktop/addons/wlsunset.nix
    # ../../features/home-manager/desktop/addons/wofi.nix
    ../../features/home-manager/terminal/kitty.nix
    ../../features/home-manager/terminal/nvim.nix
    ../../features/home-manager/terminal/ohmyzsh.nix
  ];

  home.username = "joe";
  home.homeDirectory = "/home/joe";
  programs.iamb = {
    enable = true;
    settings = {
      profiles.joe.user_id = "@joe:matrix.gladiusso.com";
      image_preview = {
        type = "kitty";
        size = {
          height = 10;
          width = 66;
        };
      };
      default_profile = "joe";
      notifications = {
        enabled = true;
      };
    };
  };
}
