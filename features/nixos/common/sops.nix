let
  defaultUsersSopsFile = ../../../users/secrets.yaml;
in {
  systemd.tmpfiles.settings = {
    "10-nix-state" = {
      "/var/lib/nix-state/secrets" = {
        d = {
          group = "root";
          mode = "0600";
          user = "root";
        };
      };
    };
  };

  sops = {
    age.keyFile = "/var/lib/nix-state/secrets/secret.key";
    defaultSopsFile = defaultUsersSopsFile;
    defaultSopsFormat = "yaml";
  };
}
