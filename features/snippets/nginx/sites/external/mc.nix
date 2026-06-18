{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    internal = false;
    ip = u.inventory.hosts.games.ip;
    port = 8100;
  }
