{
  imports = [
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./security.nix
    ./sshd.nix
  ];

  programs = {
    zsh.enable = true;
  };
}
