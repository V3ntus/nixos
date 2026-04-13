{...}: let
  inventory = import ../inventory.nix;
in {
  imports = [
    ./grafana.nix
    ./prometheus.nix

    ../vm-hardware-configuration.nix
    ../ssh.nix
    ../rsyslogd.nix

    ../../../features/nixos/common/sops.nix
    ../../../features/nixos/common/locale.nix
    ../../../features/nixos/common/nix.nix

    ../../../users/joe.nix
    ../../../users/root.nix
  ];

  networking = {
    hostName = "monitor";
    domain = inventory.domain;
    nameservers = inventory.nameservers;
    networkmanager.enable = true;
    interfaces.ens18 = {
      ipv4.addresses = [
        {
          address = inventory.hosts.monitor.ip;
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "192.168.2.1";
      interface = "ens18";
    };
    firewall.allowedTCPPorts = [];
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b8330df3-d703-40f9-9711-bfe3a4e70fbe";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/06DD-61FE";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  system.stateVersion = "24.05";
}
