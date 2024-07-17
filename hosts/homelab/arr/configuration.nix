{
  imports = [
    ../lxc-hardware-configuration.nix
    ../ssh.nix

    ../../../features/nixos/common/sops.nix
    ../../../users/root.nix
    ../../../users/joe.nix

    ./mounts.nix
    ./transmission.nix
  ];

  networking.nameservers = [
    "192.168.2.6"
    "9.9.9.9"
  ];

  fileSystems."/" = {
    device = "/dev/mapper/array-vm--103--disk--0";
    fsType = "ext4";
  };
}
