{gako358-neovim, pkgs, ...}:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFromFile = path: "lua << EOF\n${builtins.readFile path}\nEOF\n";
in {
  home.packages = [
    gako358-neovim.packages.x86_64-linux.default
    pkgs.nodejs
  ];
}
