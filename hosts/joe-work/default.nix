{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../features/nixos/common
    ../../features/nixos/desktop/hyprland.nix
    ../../features/nixos/desktop/sddm.nix

    ../../users/joe.nix
  ];

  users.users.joe.packages = [
    inputs.thorium.packages.x86_64-linux.thorium-avx
    pkgs.jetbrains.pycharm-professional
  ];
}
