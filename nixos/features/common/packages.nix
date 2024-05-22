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

  programs.nano = {
    enable = true;
    nanorc = ''
      set tabstospaces
      set tabsize 2
    '';
  };
}
