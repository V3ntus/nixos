{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    ip = u.inventory.hosts.ai.ip;
    port = 8081;
  }
