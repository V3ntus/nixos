{
  imports = [
    ./disks.nix
    ./hardware-configuration.nix

    ../../features/nixos/common
    ../../features/nixos/desktop/hyprland.nix
    ../../features/nixos/desktop/sddm.nix
    ../../features/nixos/desktop/steam.nix

    ../../users/joe.nix
  ];
}
