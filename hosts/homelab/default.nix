{nixpkgs, srvos, proxmox-nixos, sops-nix, ...}: {
  pve = import ./pve { inherit nixpkgs; inherit srvos; inherit proxmox-nixos; inherit sops-nix;};
  nix = import ./nix { inherit nixpkgs; inherit srvos; inherit proxmox-nixos; inherit sops-nix;};
  net = import ./net { inherit nixpkgs; inherit srvos; inherit proxmox-nixos; inherit sops-nix;};
  ai = import ./ai { inherit nixpkgs; inherit srvos; inherit proxmox-nixos; inherit sops-nix;};
}

