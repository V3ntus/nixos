{
  pkgs,
  config,
  nixpkgs-unstable,
  ...
}: let
  nvidiaVersion = "535.161.07";
  unstable-pkgs = import nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
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
  ];

  services.ollama.package = unstable-pkgs.ollama;
  services.open-webui.package = unstable-pkgs.open-webui;

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
    ffmpeg_7-headless
  ];

  # Use NVIDIA drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  nixpkgs.config.nvidia.acceptLicense = true;

  # NVIDIA vGPU guest configuration
  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    nvidiaSettings = false;

    # Explicitly use the GRID drivers from NVIDIA
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = nvidiaVersion;
      url = "https://storage.googleapis.com/nvidia-drivers-us-public/GRID/vGPU16.4/NVIDIA-Linux-x86_64-${nvidiaVersion}-grid.run";
      sha256_64bit = "sha256-o8dyPjc09cdigYWqkWJG6H/AP71bH65pfwFTS/7V9GM=";
      useSettings = false;
      usePersistenced = false;
    };
  };

  # Static IP assignment
  networking.hostName = "ai";
  networking.nameservers = [ "192.168.2.6" "9.9.9.9" ];
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
