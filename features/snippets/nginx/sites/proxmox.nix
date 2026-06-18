(import ./_util.nix).proxy {
  proto = "https";
  ip = "192.168.2.3";
  port = 8006;
  extraConfig = ''
    proxy_redirect off;

    include ${../conf/authelia/vhost.conf};
  '';
  extraLocationConfig = ''
    proxy_buffering off;
    client_max_body_size 0;

    include ${../conf/authelia/location.conf};
  '';
}
