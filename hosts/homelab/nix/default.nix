{
  nixpkgs,
  srvos,
  sops-nix,
  comin,
  neovim,
  ...
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  specialArgs = {inherit neovim;};

  modules = [
    sops-nix.nixosModules.sops

    srvos.nixosModules.server
    srvos.nixosModules.mixins-trusted-nix-caches
    # Enabling this experimental mixin causes auto UID assignment to cause problems for build users.
    # srvos.nixosModules.mixins-nix-experimental

    comin.nixosModules.comin
    ({...}: {
      services.comin = {
        enable = true;
        hostname = "nix";
        remotes = [
          {
            name = "origin";
            url = "https://github.com/V3ntus/nixos";
            branches.main.name = "main";
          }
        ];
      };
    })

    ./configuration.nix
  ];
}
