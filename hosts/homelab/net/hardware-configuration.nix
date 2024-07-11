{lib, modulesPath, ...}: {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "megaraid_sas" "uas" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/array-vm--100--disk--0";
    fsType = "ext4";
  };

  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

