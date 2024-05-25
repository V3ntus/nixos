{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./nix.nix
    ./sops.nix
    ./security.nix
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
