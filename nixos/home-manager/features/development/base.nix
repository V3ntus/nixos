{pkgs, ...}: {
  home.packages = with pkgs; [
    delta
  ];
}
