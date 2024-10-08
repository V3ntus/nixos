{
  neovim,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    neovide
    neovim.packages.x86_64-linux.default
    nodejs
    nerdfonts
  ];
}
