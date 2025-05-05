{
  nixpkgs,
  nixpkgs-unstable,
  srvos,
  sops-nix,
  comin,
  ...
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  specialArgs = {inherit nixpkgs-unstable;};

  modules = [
    {
      nixpkgs.overlays = [
        (final: prev: {
          technitium-dns-server = nixpkgs-unstable.legacyPackages.x86_64-linux.technitium-dns-server;
          technitium-dns-server-library = nixpkgs-unstable.legacyPackages.x86_64-linux.technitium-dns-server-library;
        })
      ];
    }
    sops-nix.nixosModules.sops

    srvos.nixosModules.server
    srvos.nixosModules.mixins-trusted-nix-caches

    comin.nixosModules.comin
    ({...}: {
      services.comin = {
        enable = true;
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
