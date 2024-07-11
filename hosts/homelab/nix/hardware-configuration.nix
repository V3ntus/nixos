{lib, ...}: {
  imports = [
    ../../../features/nixos/common/hardware.nix
  ];

  fileSystems."/" = {
    device = "/dev/mapper/array-vm--101--disk--0";
    fsType = "ext4";
  };

  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

