# To be used in configs that are built as KVM/QEMU guests
{ lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  environment.sessionVariables = { WLR_RENDERER_ALLOW_SOFTWARE = "1"; };

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = false;
  boot.initrd.availableKernelModules =
    [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
}
