{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        forceInstall = true;
        device = "nodev";
        extraConfig = ''
          serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
          terminal_input serial;
          terminal_output = serial;
        '';
      };
      systemd-boot.enable = lib.mkForce false;
      timeout = 10;
    };
    initrd = {
      availableKernelModules = ["virtio_pci" "virtio_scsi" "ahci" "sd_mod"];
      kernelModules = [];
    };
    kernelModules = [];
    kernelParams = ["console=ttyS0,19200n8"];
    extraModulePackages = [];
  };

  fileSystems."/" = {
    device = "/dev/sda";
    fsType = "ext4";
  };

  swapDevices = [
    {device = "/dev/sdb";}
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
