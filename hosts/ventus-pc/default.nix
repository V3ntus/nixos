{
  imports = [
    ./hardware-configuration.nix

    ../../features/nixos/common
    #    ../../features/nixos/virtualization/guest.nix # todo remove this
    ../../features/nixos/desktop/hyprland.nix
    ../../features/nixos/desktop/sddm.nix

    ../../users/joe.nix
  ];
}
