{pkgs, ...}: let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFromFile = path: "lua << EOF\n${builtins.readFile path}\nEOF\n";
in {
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = toLua ''
          require'lspconfig'.nil_ls.setup{}
        '';
      }
      {
        plugin = gruvbox-nvim;
        config = toLua ''
          require("gruvbox").setup()
          vim.cmd("colorscheme gruvbox")
        '';
      }
      
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/plugin.lua}
      ${builtins.readFile ./nvim/options.lua}
    '';
  };
}
