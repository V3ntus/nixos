{...}:
(import ../_util.nix).proxy {
  internal = false;
  ip = "localhost";
  port = 3004;
  extraConfig = ''
    client_max_body_size 512M;
  '';
}
