{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    ip = u.inventory.hosts.apps.ip;
    port = 2283;
  }
