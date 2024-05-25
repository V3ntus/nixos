{
  config,
  lib,
  ...
}: {
  boot.kernelModules = ["kvm-amd"];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/804f7be2-86d1-48bf-bb70-9749c36ab78a";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0121-AF44";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
