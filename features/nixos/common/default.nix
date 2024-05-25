{
  imports = [
    ./hardware.nix
    ./nix.nix
    ./sops.nix
    ./security.nix
    ./virtualization.nix
  ];

  programs.zsh.enable = true;

  system.stateVersion = "23.11";
}
