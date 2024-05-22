{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        kamadorueda.alejandra
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "gruvbox-material";
          publisher = "sainnhe";
          version = "6.5.2";
          sha256 = "sha256-D+SZEQQwjZeuyENOYBJGn8tqS3cJiWbEkmEqhNRY/i4=";
        }
      ];
  };
}
