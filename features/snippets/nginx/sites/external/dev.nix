{...}:
(import ../_util.nix).proxy {
  internal = false;
  ip = "localhost";
  port = 3002;
}
