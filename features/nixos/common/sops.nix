let
  defaultUsersSopsFile = ../../users/secrets.yaml;
in {
  sops.defaultSopsFile = defaultUsersSopsFile;
}
