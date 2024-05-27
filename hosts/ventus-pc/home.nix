{
  imports = [
    ../../features/home-manager/base.nix
    ../../features/home-manager/desktop/hyprland.nix
    ../../features/home-manager/terminal/kitty.nix
  ];

  home.username = "joe";
  home.homeDirectory = "/home/joe";
}
