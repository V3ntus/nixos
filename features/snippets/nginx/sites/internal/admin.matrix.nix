{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    ip = u.inventory.hosts.matrix.ip;
    port = 80;
  }
