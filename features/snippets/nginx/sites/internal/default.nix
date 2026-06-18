{
  pkgs,
  config,
  ...
}: let
  site_files = builtins.filter (f: (builtins.match "^[^_].*\\.nix$" f != null) && (builtins.toString f) != "default.nix") (builtins.attrNames (builtins.readDir ./.));
in
  builtins.listToAttrs (builtins.map (f: {
      name = "${pkgs.lib.strings.removeSuffix ".nix" (builtins.toString f)}.gladiusso.com";
      value = import "${builtins.toString ./.}/${f}" {inherit pkgs config;};
    })
    site_files)
