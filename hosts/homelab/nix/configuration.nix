rec {
  imports = [
    ./hardware-configuration.nix
    ../ssh.nix

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

  services.nix-serve = {
    enable = true;
    openFirewall = true;
    secretKeyFile = sops.secrets."certificates/cache-server/priv".path;
  };
}
