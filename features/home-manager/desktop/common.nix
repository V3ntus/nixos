{pkgs, ...}: {
  imports = [
    ./gtk.nix
  ];
  home.packages = with pkgs; [
    discord
  ];
}
