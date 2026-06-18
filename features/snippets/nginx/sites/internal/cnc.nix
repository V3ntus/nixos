{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    ip = u.inventory.hosts.cnc.ip;
    port = 80;
    extraLocationConfig = ''
      client_max_body_size 1G;
    '';
  }
