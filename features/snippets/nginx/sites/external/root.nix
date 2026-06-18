{...}:
(import ../_util.nix).base {
  locations = {};
  internal = false;
  otherConfig = {
    root = "/var/www/gladiusso.com";
  };
}
