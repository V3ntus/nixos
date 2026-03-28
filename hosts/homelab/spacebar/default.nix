{
  nixpkgs,
  srvos,
  sops-nix,
  comin,
  spacebar_server,
  ...
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  specialArgs = {inherit spacebar_server;};

  modules = [
    sops-nix.nixosModules.sops

    srvos.nixosModules.server
    srvos.nixosModules.mixins-trusted-nix-caches

    comin.nixosModules.comin
    ({...}: {
      services.comin = {
        enable = true;
        hostname = "net";
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
