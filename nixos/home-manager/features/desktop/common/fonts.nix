{
  apple-fonts,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    apple-fonts
    meslo-lgs-nf
  ];

  fontProfiles = {
    enable = true;
    regular = {
      family = "SF Pro Apple Font";
      package = apple-fonts.sf-pro;
    };
    monospace = {
      family = "Meslo LGS NF";
      package = pkgs.meslo-lgs-nf;
    };
  };
}
