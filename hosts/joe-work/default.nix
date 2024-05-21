{config, ...}: {
  imports = [
    ./hardware-configuration.nix

    # Users
    ../root.nix
    ../ventus.nix

    # Common imports
    ../../nixos/features/common
    ../../nixos/features/homelab
  ];

  # Boot
  boot = {
    extraModulePackages = [];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelModules = ["kvm-intel"];

    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
  };

  # Nvidia
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  # Audio
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse = {
      enable = true;
    };
  };

  system.stateVersion = "23.11";
  hardware.enableAllFirmware = true;
}
