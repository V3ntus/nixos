{
  pkgs,
  inputs,
  ...
}: {
  stylix = {
    enable = true;
    image = ../../../wallpapers/forest.jpg;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

    fonts = rec {
      serif = {
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro;
        name = "SF Pro";
      };

      sansSerif = serif;

      monospace = {
        package = pkgs.meslo-lgs-nf;
        name = "Meslo LGS NF";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
      size = 22;
    };

    opacity = {
      desktop = 0.75;
      terminal = 0.75;
    };
  };
}
