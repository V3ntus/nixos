{pkgs, ...}: rec {
  imports = [
    ../vm-hardware-configuration.nix
    ../ssh.nix

    ../../../features/nixos/common/sops.nix
    ../../../features/nixos/common/locale.nix
    ../../../features/nixos/common/nix.nix

    ../../../users/root.nix
    ../../../users/joe.nix
  ];

  # NVIDIA vGPU guest configuration
  hardware.nvidia.vgpu = {
    enable = true;

    useMyDriver = {
      enable = true;
      name = "NVIDIA-Linux-x86_64-535.161.07-grid.run";
      sha256 = "sha256-o8dyPjc09cdigYWqkWJG6H/AP71bH65pfwFTS/7V9GM=";
      driver-version = "535.161.07";
      getFromRemote = pkgs.fetchurl {
        name = hardware.nvidia.vgpu.useMyDriver.name;
        url = "https://storage.googleapis.com/nvidia-drivers-us-public/GRID/vGPU16.4/NVIDIA-Linux-x86_64-535.161.07-grid.run";
        sha256 = hardware.nvidia.vgpu.useMyDriver.sha256;
      };
    };
  };

  # Static IP assignment
  networking.hostName = "ai";
  networking.networkmanager.enable = true;
  networking.interfaces.ens18 = {
    ipv4.addresses = [
      {
        address = "192.168.2.12";
        prefixLength = 24;
      }
    ];
  };
  networking.defaultGateway = {
    address = "192.168.2.1";
    interface = "ens18";
  };

  # GRUB definition for BIOS legacy
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  fileSystems."/" =  {
    device = "/dev/disk/by-uuid/357b03f5-d461-47cf-93e2-8fa1c50ef723";
    fsType = "ext4";
  };
}
