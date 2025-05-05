{
  nixpkgs,
  nixpkgs-unstable,
  srvos,
  sops-nix,
  comin,
  neovim,
  ...
}: {
  nix = import ./nix {
    inherit nixpkgs;
    inherit srvos;
    inherit sops-nix;
    inherit comin;
    inherit neovim;
  };
  net = import ./net {
    inherit nixpkgs;
    inherit nixpkgs-unstable;
    inherit srvos;
    inherit sops-nix;
    inherit comin;
  };
  ai = import ./ai {
    inherit nixpkgs;
    inherit nixpkgs-unstable;
    inherit srvos;
    inherit sops-nix;
    inherit comin;
  };
  arr = import ./arr {
    inherit nixpkgs;
    inherit nixpkgs-unstable;
    inherit srvos;
    inherit sops-nix;
    inherit comin;
  };
  apps = import ./apps {
    inherit nixpkgs;
    inherit srvos;
    inherit sops-nix;
    inherit comin;
  };
}
