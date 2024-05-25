{
  imports = [
    ./hardware-configuration.nix

    ../../features/nixos/common
    ../../features/nixos/desktop/hyprland.nix

    ../../users/ventus.nix
  ];
}
