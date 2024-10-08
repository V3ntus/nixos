{
  nixpkgs,
  srvos,
  sops-nix,
  comin,
  ...
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
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
