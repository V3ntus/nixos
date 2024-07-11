{config, ...}: rec {
  imports = [
    ./hardware-configuration.nix

    ../../../features/nixos/common/sops.nix
  ];

  sops.secrets = {
    "certificates/cache-server/priv" = {
      mode = "0400";
      owner = "nix-serve";
      group = "nix-serve";
      path = "/var/lib/nix-state/secrets/cache-server-priv.pem";
    };
  };

  services.nix-serve = {
    enable = true;
    openFirewall = true;
    secretKeyFile = sops.secrets."certificates/cache-server/priv".path;
  };
}