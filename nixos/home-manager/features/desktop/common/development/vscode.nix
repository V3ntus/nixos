{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "gruvbox-material";
          publisher = "sainnhe";
          version = "6.5.2";
          sha256 = ""; # TODO change this
        }
        {
          name = "alejandra";
          publisher = "kamadorueda";
          version = "1.4.0";
          sha256 = ""; # TODO change this
        }
      ];
  };
}
