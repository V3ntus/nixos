{
  imports = [
    ../../features/home-manager/base.nix
    ../../features/home-manager/desktop/hyprland.nix
  ];

  home.username = "ventus";
  home.homeDirectory = "/home/ventus";
}
