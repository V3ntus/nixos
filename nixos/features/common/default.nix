{...}: {
  imports = [
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./security.nix
    ./shell.nix
    ./sshd.nix
  ];
}
