{
  imports = [
    ./sops.nix
    ./hardware.nix
  ];

  programs.zsh.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "23.11";
}
