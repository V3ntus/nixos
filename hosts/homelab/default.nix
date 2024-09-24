{
  nixpkgs,
  srvos,
  sops-nix,
  comin,
  ...
}: {
  nix = import ./nix {
    inherit nixpkgs;
    inherit srvos;
    inherit sops-nix;
    inherit comin;
  };
  net = import ./net {
    inherit nixpkgs;
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
    inherit srvos;
    inherit sops-nix;
    inherit comin;
  };
}
