{
  imports = [
    ./hardware-configuration.nix
    ../ssh.nix

    ../../../features/nixos/common/sops.nix
    ../../../users/root.nix
    ../../../users/joe.nix
  ];

  services.technitium-dns-server = {
    enable = true;
    openFirewall = true;
  };
}
