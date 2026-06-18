{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    internal = false;
    ip = u.inventory.hosts.ai.ip;
    port = 8096;
    needAuth = true;
  }
