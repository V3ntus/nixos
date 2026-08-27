{options, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./programs.nix
    ./networking.nix
    ./fail2ban.nix
    ./pangolin.nix
    ./nginx.nix

    ../../features/nixos/common/hardware.nix
    ../../features/nixos/common/locale.nix
    ../../features/nixos/common/nix.nix
    ../../features/nixos/common/security.nix
    ../../features/nixos/common/sops.nix

    ../../users/root.nix
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "without-password";
      PasswordAuthentication = false;
      Banner = ../../features/nixos/terminal/banner.txt;
    };
  };

  services.ntp.enable = true;
  networking.timeServers = options.networking.timeServers.default;

  services.logrotate.checkConfig = false;

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  system.stateVersion = "23.11";
}
