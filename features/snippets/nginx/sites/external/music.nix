{...}:
(import ../_util.nix).base {
  locations."/pages/".tryFiles = "$uri $uri.html";
  internal = false;
  otherConfig = {
    root = "/var/www/music.gladiusso.com";
  };
}
