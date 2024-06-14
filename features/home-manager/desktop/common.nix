{pkgs, ...}: {
  imports = [
    ./stylix.nix
  ];
  home.packages = with pkgs; [
    discord
  ];
}
