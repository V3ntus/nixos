{
  nixpkgs,
  nixpkgs-unstable,
  srvos,
  sops-nix,
  comin,
  neovim,
  spacebar_server,
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
  spacebar = import ./spacebar {
    inherit nixpkgs;
    inherit srvos;
    inherit sops-nix;
    inherit comin;
    inherit spacebar_server;
  };
}
