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
        device = "/dev/sda";
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
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod"];
      kernelModules = ["nvme"];
    };
    kernelModules = ["kvm-intel"];
    kernelParams = ["console=ttyS0,19200n8"];
    extraModulePackages = [];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7bd6d323-590a-4f70-b655-f2f311142d2b";
    fsType = "ext4";
  };

  fileSystems."/efi" = {
    device = "systemd-1";
    fsType = "autofs";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
