rec {
  imports = [
    ../lxc-hardware-configuration.nix
    ../ssh.nix

    ../../../features/nixos/terminal/nvim.nix
    ../../../features/nixos/terminal/ohmyzsh.nix
    ../../../features/nixos/common/sops.nix
    ../../../users/root.nix
    ../../../users/joe.nix
  ];

  sops.secrets = {
    "certificates/cache-server/priv" = {
      mode = "0400";
      owner = "root";
      group = "root";
      path = "/var/lib/nix-state/secrets/cache-server-priv.pem";
    };
  };

  programs.zsh.shellAliases.deploy = "nix run github:serokell/deploy-rs";

  networking.hostName = "nix";
  networking.nameservers = [
    "192.168.2.6"
    "9.9.9.9"
  ];
  networking.search = [
    "gladiusso.com"
  ];

  services.nix-serve = {
    enable = true;
    openFirewall = true;
    secretKeyFile = sops.secrets."certificates/cache-server/priv".path;
  };

  fileSystems."/" = {
    device = "/dev/mapper/array-vm--101--disk--0";
    fsType = "ext4";
  };
}
