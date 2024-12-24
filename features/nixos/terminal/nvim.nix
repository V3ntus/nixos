{
  pkgs,
  neovim,
  ...
}: {
  environment.systemPackages = with pkgs; [
    neovide
    nodejs
    nerdfonts
    neovim.packages.x86_64-linux.default
  ];
}
