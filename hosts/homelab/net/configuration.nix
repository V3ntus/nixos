{nixpkgs-unstable, ...}: {
  imports = [
    ../lxc-hardware-configuration.nix
    ../ssh.nix

    ./nginx.nix
    ./homepage.nix

    ../../../features/nixos/common/sops.nix
    ../../../features/nixos/common/security.nix
    ../../../users/root.nix
    ../../../users/joe.nix
  ];

  services.resolved.enable = false;

  networking.hostName = "net";
  networking.nameservers = ["127.0.0.1" "9.9.9.9"];

  services.technitium-dns-server = {
    enable = true;
    openFirewall = true;
    package = nixpkgs-unstable.legacyPackages.x86_64-linux.technitium-dns-server;
  };

  fileSystems."/" = {
    device = "/dev/mapper/array-vm--100--disk--0";
    fsType = "ext4";
  };
}
