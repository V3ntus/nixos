{pkgs, ...}: {
  imports = [
    ./editor/lazyvim.nix
    ./languages/flutter.nix
    ./languages/python.nix
  ];

  home.packages = with pkgs; [
    delta
  ];
}
