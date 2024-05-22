require'colorizer'.setup()
require("gitsigns").setup()
require('Comment').setup()
vim.opt.list = true
vim.opt.listchars:append ""
require("indent_blankline").setup {
    show_end_of_line = false,
}

cmd[[colorscheme tokyonight-moon]]