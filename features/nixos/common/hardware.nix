{
  modulesPath,
  lib,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.extraModulePackages = [];
  boot.initrd.kernelModules = [];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
