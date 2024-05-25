let
  defaultUsersSopsFile = ../../users/secrets.yaml;
in {
  sops.age.keyFile = "/home/ventus/repos/nixos/secret.key";
  sops.defaultSopsFile = defaultUsersSopsFile;
}
