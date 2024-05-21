{pkgs, ...}: {
  home.packages = with pkgs; [
    flutter
    gnome.adwaita-icon-theme
  ];
}
