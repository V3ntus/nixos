{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    internal = false;
    ip = u.inventory.hosts.net.ip;
    port = 8182;
    needAuth = true;
    extraLocationConfig = ''
      proxy_read_timeout 300;
    '';
  }
