{pkgs, ...}: let
  u = import ../_util.nix;
in
  u.base {
    locations = {};
    internal = false;
    otherConfig = {
      root = pkgs.cinny;
    };
  }
