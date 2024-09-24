{
  modulesPath,
  lib,
  pkgs,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  # Configure gaming mice/peripherals
  services.ratbagd.enable = true;

  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;
  boot.extraModulePackages = [];
  boot.initrd.kernelModules = [];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.enableRedistributableFirmware = lib.mkDefault true;
  hardware.graphics.enable = true;
}
