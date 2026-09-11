{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    ip = u.inventory.hosts.matrix.ip;
    port = 3000;
    internal = false;
    needAuth = false;
    extraConfig = ''
      client_max_body_size 80m;
    '';
  }
