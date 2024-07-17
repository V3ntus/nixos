{nixpkgs, srvos, sops-nix, ...}: nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
    sops-nix.nixosModules.sops

    srvos.nixosModules.server
    srvos.nixosModules.mixins-trusted-nix-caches
    # Enabling this experimental mixin causes auto UID assignment to cause problems for build users.
    # srvos.nixosModules.mixins-nix-experimental

    ./configuration.nix
  ];
}
