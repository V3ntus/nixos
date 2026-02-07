{
  pkgs,
  neovim,
  ...
}: {
  environment.systemPackages = with pkgs; [
    neovide
    nodejs
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    neovim.packages.x86_64-linux.default
  ];
}
