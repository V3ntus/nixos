{pkgs, ...}: {
  imports = [
    ../../features/home-manager/base.nix
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
    alsa-scarlett-gui
  ];
}
