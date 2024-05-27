let
  defaultUsersSopsFile = ../../users/secrets.yaml;
in {
  sops.age.keyFile = "/home/joe/repos/nixos/secret.key";
  sops.defaultSopsFile = defaultUsersSopsFile;
  sops.defaultSopsFormat = "yaml";
}
