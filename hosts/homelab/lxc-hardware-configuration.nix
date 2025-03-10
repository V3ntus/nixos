{
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/virtualisation/proxmox-lxc.nix")];

  boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "megaraid_sas" "uas"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  nix.optimise.automatic = lib.mkForce false;
  nix.gc.automatic = true;

  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
