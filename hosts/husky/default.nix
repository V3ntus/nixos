# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../features/nixos/common
    ../../features/nixos/desktop/mango.nix
    ../../features/nixos/desktop/noctalia.nix
    ../../users/joe.nix
    ../../users/root.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "husky";
  networking.domain = "gladiusso.com";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    discordo
    inputs.matui.packages.x86_64-linux.matui
  ];

  networking.firewall.allowedTCPPorts = [22];
  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
