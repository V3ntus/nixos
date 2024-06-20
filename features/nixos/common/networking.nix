{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dig  # dns lookup
    trippy  # traceroute/mtr alternative
  ];

  networking.networkmanager.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
