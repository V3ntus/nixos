{
  lib,
  config,
  ...
}: {
  # Add NVIDIA package
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  hardware.graphics = {enable = true;};

  services.xserver.videoDrivers = lib.mkForce ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    #prime = {
    #  sync.enable = true;
    #  intelBusId = "PCI:0:2:0";
    #  nvidiaBusId = "PCI:1:0:0";
    #};
  };
}
