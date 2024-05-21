{pkgs, ...}: {
  programs = {
    yazi.enable = true; # TUI file manager
  };

  home.packages = with pkgs; [
    # Nix
    alejandra # nix formatter
    nil # nix language server
    nvd # nix diff

    # Shell
    fastfetch # neofetch alternative
    eza # ls alternative
    btop # top alternative
    htop # top alternative
    bat # cat alternative
    httpie # TUI "Postman"
    jq # pretty print JSON
    ripgrep # better grep
  ];
}
