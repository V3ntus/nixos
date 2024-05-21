{pkgs, ...}: rec {
  gtk = {
    iconTheme = {
      name = "whitesur-icon-theme";
      package = pkgs.whitesur-icon-theme;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };
}
