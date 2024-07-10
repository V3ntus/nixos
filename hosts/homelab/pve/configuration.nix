{lib, ...}: {
  imports = [
    ../../../features/nixos/common/locale.nix
    ../../../features/nixos/common/networking.nix
    ../../../features/nixos/common/nix.nix
    ../../../features/nixos/common/security.nix
    ../../../features/nixos/common/sops.nix
    ./hardware-configuration.nix
  ];

  services.proxmox-ve = {
    enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
    };
  };

  networking = {
    # LAN bridge for Proxmox
    bridges = {
      vmbr0.interfaces = [
        "enp4s0f0"
      ];
    };
    interfaces = {
      # Proxmox bridge
      vmbr0 = {
        useDHCP = lib.mkDefault true;
      };

      # LAN
      enp4s0f0 = {
        useDHCP = false;
        ipv4 = {
          addresses = [{
            address = "192.168.2.3";
            prefixLength = 24;
          }];
        };
      };
      # WAN (unused)
      enp4s0f1 = {
        useDHCP = true;
        ipv4 = {
          addresses = [];
        };
      };
    };
    firewall = {
      interfaces = {
        enp4s0f0 = {
          allowedTCPPorts = [
            8006 # Proxmox manager UI
          ];
        };
      };
    };
  };
}
