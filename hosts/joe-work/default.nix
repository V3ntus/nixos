{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../features/nixos/common
    ../../features/nixos/common/wireguard.nix
    ../../features/nixos/desktop/hyprland.nix
    ../../features/nixos/desktop/niri.nix
    ../../features/nixos/desktop/stylix.nix
    ../../features/nixos/desktop/sddm.nix
    ../../features/nixos/virtualization/docker.nix

    ../../users/joe.nix
  ];

  sops.secrets = {
    "wireguard/joe-work/privkey" = { sopsFile = ../../users/secrets.yaml; };
  };

  users.users.joe.packages = [
    inputs.thorium.packages.x86_64-linux.thorium-avx
    pkgs.jetbrains.pycharm-professional
  ];

  networking.wg-quick.interfaces.wg0.address =
    [ "10.143.245.4/24" "fd11:5ee:bad:c0de::4/64" ];
  networking.wg-quick.interfaces.wg0.dns = [ "192.168.2.6" "9.9.9.9" ];
  networking.wg-quick.interfaces.wg0.privateKeyFile =
    config.sops.secrets."wireguard/joe-work/privkey".path;
}
