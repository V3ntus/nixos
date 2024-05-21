{lib, ...}: {
  options = {
    homelab.domain = lib.mkOption {
      type = lib.types.str;
      default = null;
      description = "Homelab master domain for public and private use.";
    };
  };

  config = {
    homelab.domain = (builtins.fromJSON (builtins.readFile ../../../../homelab.json)).domain;
  };
}
