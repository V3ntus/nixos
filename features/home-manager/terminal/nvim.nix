{pkgs, ...}:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
in {
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      {
        plugin = gruvbox-nvim;
        config = toLua ''
          require("gruvbox").setup()
          vim.cmd("colorscheme gruvbox")
        '';
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';
  };
}
