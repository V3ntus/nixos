{nixpkgs, srvos, proxmox-nixos, sops-nix, ...}: nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";

  modules = [
    proxmox-nixos.nixosModules.proxmox-ve
    sops-nix.nixosModules.sops

    {
      nixpkgs.overlays = [
        (self: super: {
          # src: https://github.com/NixOS/nixpkgs/commit/7e94ac48e0c68bdc9d2b39e50e024e7170f83838
          # issue/PR: https://github.com/NixOS/nixpkgs/pull/325059
          ceph = super.ceph.overrideAttrs {
            postPatch = ''
              substituteInPlace cmake/modules/Finduring.cmake \
                --replace-fail "liburing.a liburing" "uring"
            '';
          };
        })
        proxmox-nixos.overlays.${system}
      ];
    }

    ./configuration.nix
  ];
}
