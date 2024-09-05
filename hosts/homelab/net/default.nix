{ nixpkgs, srvos, sops-nix, ... }:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
    sops-nix.nixosModules.sops

    srvos.nixosModules.server
    srvos.nixosModules.mixins-trusted-nix-caches

    ./configuration.nix
  ];
}
