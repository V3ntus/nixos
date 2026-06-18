{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    ip = u.inventory.hosts.monitor.ip;
    port = 3000;
  }
