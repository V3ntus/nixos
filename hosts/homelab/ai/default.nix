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

  specialArgs = {
    inherit nixpkgs-unstable;
  };

  modules = [
    {
      nixpkgs.overlays = [
        (final: prev: let
          pkgs-unstable = import nixpkgs-unstable {
            config.allowUnfree = true;
            system = "x86_64-linux";
          };
        in {
          # ollama = pkgs-unstable.ollama;
          # open-webui = pkgs-unstable.open-webui;
        })
      ];
    }

    sops-nix.nixosModules.sops

    srvos.nixosModules.server
    srvos.nixosModules.mixins-trusted-nix-caches
    srvos.nixosModules.mixins-nix-experimental

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
