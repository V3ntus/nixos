{
  imports = [
    ./hardware-configuration.nix

    ../../features/nixos/common
    ../../features/nixos/virtualization/guest.nix
    ../../features/nixos/desktop/hyprland.nix

    ../../users/ventus.nix
  ];
}
