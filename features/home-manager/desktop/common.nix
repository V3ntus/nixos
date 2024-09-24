{pkgs, ...}: {
  imports = [./stylix.nix];
  home.packages = with pkgs; [vesktop];
}
