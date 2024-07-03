{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./services.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.kernelParams = [ "console=ttyS0" ];
  boot.loader.systemd-boot = {
    enable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "ai";
  networking.networkmanager.enable = true;
  networking.interfaces = {
    enp6s18 = {
      ipv4.addresses = [
        {
          address = "192.168.2.12";
          prefixLength = 24;
        }
      ];
    };
  };
  networking.defaultGateway = {
    address = "192.168.2.1";
    interface = "enp6s18";
  };

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb.layout = "us";

  # User & Packages
  users.users.ventus = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      dig
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    nvtopPackages.nvidia
    ffmpeg
  ];

  programs.mtr.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = lib.mkForce true;
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    80
    7860
    8080
    8081
    8082
    22
  ];

  system.stateVersion = "24.05";
}
