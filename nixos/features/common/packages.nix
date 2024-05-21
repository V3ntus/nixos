{pkgs, ...}: {
  imports = [];

  environment.systemPackages = with pkgs; [
    file
    lsof
    usbutils
    pciutils
    lshw

    dig

    dmidecode
    sops
  ];
}
