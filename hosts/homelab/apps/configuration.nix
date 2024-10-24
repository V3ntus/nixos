{lib, ...}: {
  imports = [
    ../lxc-hardware-configuration.nix
    ../ssh.nix

    ./kitchen.nix

    ../../../features/nixos/common/sops.nix
    ../../../users/root.nix
    ../../../users/joe.nix
  ];

  services.resolved.enable = lib.mkForce false;

  networking.hostName = "apps";
  networking.nameservers = ["192.168.2.6" "9.9.9.9"];
  networking.firewall.allowedTCPPorts = [8001];

  fileSystems."/" = {
    device = "/dev/mapper/array-vm--104--disk--0";
    fsType = "ext4";
  };
}
