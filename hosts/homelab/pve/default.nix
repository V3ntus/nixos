{nixpkgs, srvos, proxmox-nixos, ...}: nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";

  modules = [
    proxmox-nixos.nixosModules.proxmox-ve

    {
      nixpkgs.overlays = [
        proxmox-nixos.overlays.${system}
      ];
    }

    ./configuration.nix
  ];
}
