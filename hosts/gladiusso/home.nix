{
  imports = [
    ../../features/home-manager/security.nix
    ../../features/home-manager/terminal/ohmyzsh.nix
  ];

  home.username = "joe";
  home.homeDirectory = "/home/joe";
  home.stateVersion = "23.11";
}
