{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./nix.nix
    ./security.nix
    ./sops.nix
    ./virtualization.nix
  ];

  # Baseline shell operations
  programs.zsh.enable = true;
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    wget
    curl
  ];

  system.stateVersion = "23.11";
}
