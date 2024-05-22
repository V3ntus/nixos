{
  lib,
  config,
  pkgs,
  ...
}: {
  home = {
    username = lib.mkDefault "ventus";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.11";
  };

  programs = {
    git = {
      enable = true;
      userName = "V3ntus";
      userEmail = "29584664+V3ntus@users.noreply.github.com";
      extraConfig = {
        core.pager = "delta";
        interactive.difffilter = "delta --color-only --features=interactive";
        delta.side-by-side = true;
        delta.navigate = true;
      };
    };
  };

  home.packages = with pkgs; [
    nano
    nodejs
    tree-sitter

    trippy # mtr alternative

    gimp

    discord
    libreoffice-qt

    wireguard-tools
  ];
}
