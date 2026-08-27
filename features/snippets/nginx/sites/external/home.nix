{...}:
(import ../_util.nix).proxy {
  ip = "192.168.2.6";
  port = 8082;
  internal = false;
  needAuth = true;
}
