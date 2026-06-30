{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    internal = false;
    ip = u.inventory.hosts.nix.ip;
    port = 3000;
    extraConfig = ''
      client_max_body_size 512M;
    '';
  }
