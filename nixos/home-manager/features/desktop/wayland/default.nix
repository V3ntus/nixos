{pkgs, ...}: {
  home.packages = with pkgs; [
    vlc
    kate
  ];
}
