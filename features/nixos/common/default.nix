{
  imports = [
    ./sops.nix
  ];

  programs.zsh.enable = true;

  system.stateVersion = "23.11";
}
