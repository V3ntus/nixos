{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  disabledModules = ["programs/wayland/niri.nix"];

  programs.niri.enable = true;
}
