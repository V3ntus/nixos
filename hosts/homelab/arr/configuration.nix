{
  imports = [
    ../vm-hardware-configuration.nix
    ../ssh.nix

    ../../../features/nixos/common/sops.nix
    ../../../users/root.nix
    ../../../users/joe.nix

    ./mounts.nix
    ./transmission.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  networking.nameservers = [
    "192.168.2.6"
    "9.9.9.9"
  ];

  networking.defaultGateway = {
    address = "192.168.2.1";
    interface = "ens18";
  };

  networking.interfaces.ens18.ipv4.addresses = [{
    address = "192.168.2.4";
    prefixLength = 24;
  }];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/43345740-955b-4550-8d6a-5d8c15eb28b7";
    fsType = "ext4";
  };
}
