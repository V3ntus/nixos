{...}: let
  u = import ../_util.nix;
in
  u.proxy {
    internal = false;
    ip = u.inventory.hosts.net.ip;
    port = 9091;
    extraLocationConfig = ''
      include ${../../conf/authelia/proxy.conf};
    '';
    locations = {
      "/api/verify" = {
        proxyPass = "http://${u.inventory.hosts.net.ip}:9091";
      };
      "/api/authz" = {
        proxyPass = "http://${u.inventory.hosts.net.ip}:9091";
      };
    };
  }
