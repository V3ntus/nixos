{config, ...}: rec {
  services.nix-serve = {
    enable = true;
  };

  sops.secrets = {
    "certificates/cache-server/priv" = {
      mode = "0400";
      owner = config.users.users.nix-serve.name;
      group = config.users.users.nix-serve.group;
      path = "/var/lib/nix-state/secrets/cache-server-priv.pem";
    };
  };

  services.nix-serve = {
    enable = true;
    openFirewall = true;
    secretKeyFile = sops.secrets."certificates/cache-server/priv".path;
  };
}
