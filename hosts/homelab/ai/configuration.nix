{
  pkgs,
  config,
  ...
}: let
  nvidiaVersion = "550.54.14";
  gridVersion = "17.0";
in {
  imports = [
    ../vm-hardware-configuration.nix
    ../ssh.nix

    ../../../features/nixos/common/sops.nix
    ../../../features/nixos/common/locale.nix
    ../../../features/nixos/common/nix.nix

    ../../../users/root.nix
    ../../../users/joe.nix

    ./ai_services.nix
    ./jellyfin.nix
    ./mounts.nix
  ];

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
    ffmpeg_7-headless
  ];

  # Use NVIDIA drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.cudaSupport = true;

  # NVIDIA vGPU guest configuration
  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    nvidiaSettings = false;

    # Explicitly use the GRID drivers from NVIDIA
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = nvidiaVersion;
      url = "https://storage.googleapis.com/nvidia-drivers-us-public/GRID/vGPU${gridVersion}/NVIDIA-Linux-x86_64-${nvidiaVersion}-grid.run";
      sha256_64bit = "sha256-AhyxF+FOxUWiTbP0DmZMX6a7lQ3XX6rb5XPBAYeMmeM=";
      useSettings = false;
      usePersistenced = false;
      patches = [
        ./00-follow_pfn.patch
        ./01-dma_buf_map.patch
        ./02-drm-hotplug-helper.patch
      ];
    };
  };

  # Static IP assignment
  networking.hostName = "ai";
  networking.nameservers = ["192.168.2.6" "9.9.9.9"];
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
  networking.firewall.allowedTCPPorts = [
    config.services.ollama.port
  ];

  # GRUB definition for BIOS legacy
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/357b03f5-d461-47cf-93e2-8fa1c50ef723";
    fsType = "ext4";
  };

  system.stateVersion = "24.11";
}
