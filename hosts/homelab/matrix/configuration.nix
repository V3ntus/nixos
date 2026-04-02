{
  pkgs,
  lib,
  ...
}: let
  deployCert = pkgs.writeShellScriptBin "deploy_cert" ''
    #!${pkgs.bashInteractive}/bin/bash
    IN=$(</dev/stdin)

    mkdir -p /etc/coturn

    case $1 in
      -pkey)
        echo $IN > /etc/coturn/key.pem
        ;;
      -cert)
        echo $IN > /etc/coturn/full.pem
        ;;
    esac
  '';
in {
  imports = [
    ./db.nix
    ./synapse.nix
    ./nginx.nix

    ../lxc-hardware-configuration.nix
    ../ssh.nix
    ../rsyslogd.nix

    ../../../features/nixos/common/sops.nix
    ../../../features/nixos/common/security.nix
    ../../../users/root.nix
    ../../../users/joe.nix
  ];

  environment.systemPackages = [
    deployCert
  ];

  users.users.certsync = {
    isNormalUser = true;
    shell = pkgs.bashInteractive;
    createHome = false;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIELD8FP0JjwMIdPeVq6ToM9A2LQ2TGeofl31vs0WAeqd cert sync"];
  };

  security.sudo = {
    enable = true;
    execWheelOnly = lib.mkForce false;
    extraRules = [
      {
        users = ["certsync"];
        commands = [deployCert.outPath];
      }
    ];
  };

  networking = {
    fqdn = "matrix.gladiusso.com";
    hostName = "matrix";
    nameservers = [
      "192.168.2.6"
      "9.9.9.9"
    ];
    search = [
      "gladiusso.com"
    ];
    domain = "gladiusso.com";
  };

  fileSystems."/" = {
    device = "/dev/mapper/r0-vm--108--disk--0";
    fsType = "ext4";
  };
}
