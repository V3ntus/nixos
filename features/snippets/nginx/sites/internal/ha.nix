{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    ip = u.inventory.hosts.ha.ip;
    port = 8123;
  }
