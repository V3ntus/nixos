{
  imports = [
    ./hardware-configuration.nix

    ../../../features/nixos/common/sops.nix
    ../../../users/root.nix
  ];

  services.technitium-dns-server = {
    enable = true;
    openFirewall = true;
  };
}
