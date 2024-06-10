{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dig
  ];

  networking.networkmanager.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
