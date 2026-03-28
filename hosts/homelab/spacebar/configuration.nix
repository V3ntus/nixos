{
  imports = [
    ./db.nix
    ./spacebar.nix
    ./fermi.nix

    ../lxc-hardware-configuration.nix
    ../ssh.nix
    ../rsyslogd.nix

    ../../../features/nixos/common/sops.nix
    ../../../features/nixos/common/security.nix
    ../../../users/root.nix
    ../../../users/joe.nix
  ];

  networking = {
    hostName = "spacebar";
    nameservers = [
      "192.168.2.6"
      "9.9.9.9"
    ];
    search = [
      "gladiusso.com"
    ];
    firewall = {
      allowedTCPPorts = [
        3001
        3002
      ];
      allowedUDPPorts = [
        3001
      ];
    };
  };

  fileSystems."/" = {
    device = "/dev/mapper/r0-vm--108--disk--0";
    fsType = "ext4";
  };
}
