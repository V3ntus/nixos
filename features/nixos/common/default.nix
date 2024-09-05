{ pkgs, lib, ... }: {
  imports = [
    ./audio.nix
    ./desktop.nix
    ./fonts.nix
    ./hardware.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./sops.nix
    ./virtualization.nix
  ];

  # Baseline shell operations
  programs.zsh.enable = true;
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [ wget curl file ];
  programs.nano.nanorc = ''
    set tabstospaces
    set tabsize 2
  '';

  system.stateVersion = lib.mkDefault "23.11";
}
