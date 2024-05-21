{...}: {
  imports = [
    ./features/starship.nix
    ./features/zsh.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    warn-dirty = false;
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
    nix-index.enable = true;
  };
}
