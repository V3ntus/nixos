{lib, ...}: {
  imports = [
    ../lxc-hardware-configuration.nix
    ../ssh.nix

    ./kitchen.nix
    ./photos.nix

    ../../../features/nixos/common/sops.nix
    ../../../users/root.nix
    ../../../users/joe.nix
  ];

  networking = {
    hostName = "apps";
    nameservers = ["192.168.2.6" "9.9.9.9"];
    firewall.allowedTCPPorts = [8001];
  };

  fileSystems."/" = {
    device = "/dev/mapper/array-vm--104--disk--0";
    fsType = "ext4";
  };
}
