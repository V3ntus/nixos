{
  apple-fonts,
  pkgs,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    apple-fonts.packages.x86_64-linux.sf-pro
    meslo-lgs-nf
  ];
}
