{
  neovim,
  pkgs,
  ...
}: let
  toLua = str: ''
    lua << EOF
    ${str}
    EOF
  '';
  toLuaFromFile = path: ''
    lua << EOF
    ${builtins.readFile path}
    EOF
  '';
in {
  home.packages = [pkgs.neovide neovim.packages.x86_64-linux.default pkgs.nodejs];
}
