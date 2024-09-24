{
  config,
  lib,
  ...
}: {
  boot.kernelModules = ["kvm-intel"];
  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
  '';

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e7667778-f6f6-4942-9698-2700c4bd1547";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/AA71-C066";
    fsType = "vfat";
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
