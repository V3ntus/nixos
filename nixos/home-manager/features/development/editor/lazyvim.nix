{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      tree-sitter
      nodejs

      pyright
      rnix-lsp

      nodePackages.pyright
      nodePackages.typescript-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      # UI
      gruvbox
      nvim-web-devicons
      gitsigns-nvim

      # LSP
      coq_nvim
      nvim-lspconfig

      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-bash
        p.tree-sitter-json
        p.tree-sitter-json5
        p.tree-sitter-jsonc
        p.tree-sitter-dart
        p.tree-sitter-nix
        p.tree-sitter-python
      ]))
    ];

    extraConfig = ''
      lua << EOF
        ${builtins.readFile lua/init.lua}
        ${builtins.readFile lua/web-icons.lua}
      EOF
    '';
  };
}
