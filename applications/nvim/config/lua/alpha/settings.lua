local opt = vim.opt
local g = vim.g

g.mapleader = ' '
g.snippets = "luasnip"

opt.undofile = true
-- TODO change to environment variable
opt.undodir = "/home/alpha/.cache"

opt.number = true
opt.relativenumber = true

opt.laststatus = 3

opt.wrap = false
opt.backup = false
opt.writebackup = false
opt.errorbells = false
opt.swapfile = false

opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.clipboard = "unnamedplus"

opt.termguicolors = true
opt.number = true
opt.relativenumber = true

opt.viminfo = ""
opt.viminfofile = "NONE"

opt.smartcase = true
opt.ttimeoutlen = 5
opt.compatible = false
opt.autoread = true
opt.incsearch = true
opt.hidden = true
opt.shortmess = "atI"

opt.splitbelow = true
opt.splitright = true

opt.updatetime = 50
opt.scrolloff = 4
opt.sidescrolloff = 4

-- Set Color scheme, I don't know a lua way to directly do it
vim.cmd([[colorscheme nightfox]])
