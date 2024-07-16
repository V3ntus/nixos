{
  imports = [
    ../lxc-hardware-configuration.nix
    ../ssh.nix

    ./nginx.nix
    ./homepage.nix

    ../../../features/nixos/common/sops.nix
    ../../../users/root.nix
    ../../../users/joe.nix
  ];

  services.technitium-dns-server = {
    enable = true;
    openFirewall = true;
  };

  fileSystems."/" = {
    device = "/dev/mapper/array-vm--100--disk--0";
    fsType = "ext4";
  };
}
