{
  imports = [
    ./hardware-configuration.nix

    ../../features/nixos/common
    ../../features/nixos/desktop/hyprland.nix
    ../../features/nixos/desktop/sddm.nix

    ../../users/joe.nix
  ];
}
