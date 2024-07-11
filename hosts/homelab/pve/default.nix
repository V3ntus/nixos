{nixpkgs, srvos, proxmox-nixos, sops-nix, ...}: nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";

  modules = [
    proxmox-nixos.nixosModules.proxmox-ve
    sops-nix.nixosModules.sops

    {
      nixpkgs.overlays = [
        proxmox-nixos.overlays.${system}
      ];
    }

    ./configuration.nix
  ];
}
