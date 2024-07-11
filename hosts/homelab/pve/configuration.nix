{lib, ...}: {
  imports = [
    ../../../features/nixos/common/locale.nix
    ../../../features/nixos/common/networking.nix
    ../../../features/nixos/common/nix.nix
    ../../../features/nixos/common/sops.nix
    ../ssh.nix
    ./hardware-configuration.nix
  ];

  services.proxmox-ve = {
    enable = true;
  };

  programs.git.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
    };
  };

  networking = {
    usePredictableInterfaceNames = lib.mkForce true;
    hostName = "pve";
    # LAN bridge for Proxmox
    bridges = {
      vmbr0.interfaces = [
        "eno1"
      ];
    };
    interfaces = {
      # LAN
      vmbr0 = {
	useDHCP = false;
        ipv4 = {
          addresses = [{
            address = "192.168.2.3";
            prefixLength = 24;
          }];
        };
      };
      # WAN (unused)
      eno2 = {
        useDHCP = false;
        ipv4 = {
          addresses = [];
        };
      };
    };
    defaultGateway = {
      address = "192.168.2.1";
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

  system.stateVersion = "24.11";
}
