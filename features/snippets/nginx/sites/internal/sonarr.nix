{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    ip = u.inventory.hosts.arr.ip;
    port = 8989;
  }
