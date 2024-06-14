{
  pkgs,
  inputs,
  ...
}: {
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    inputs.apple-fonts.packages.${system}.sf-pro
    meslo-lgs-nf
  ];
}
