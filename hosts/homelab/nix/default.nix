{nixpkgs, sops-nix, ...}: nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
    sops-nix.nixosModules.sops

    ./configuration.nix
  ];
}
