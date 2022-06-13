vim.cmd([[
autocmd BufWritePre * :%s/\s\+$//e
]])

