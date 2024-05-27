{
  imports = [
    ../../features/home-manager/base.nix
    ../../features/home-manager/desktop/hyprland.nix
    ../../features/home-manager/terminal/kitty.nix
    ../../features/home-manager/terminal/nvim.nix
  ];

  home.username = "joe";
  home.homeDirectory = "/home/joe";
}
