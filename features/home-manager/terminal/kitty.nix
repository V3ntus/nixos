{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Meslo LGS NF";
      package = pkgs.meslo-lgs-nf;
    };
  };
}
