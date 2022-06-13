-- Window movement
vim.keymap.set("n", "<leader>wh", ":wincmd h<cr>", { remap = false })
vim.keymap.set("n", "<leader>wj", ":wincmd j<cr>", { remap = false })
vim.keymap.set("n", "<leader>wk", ":wincmd k<cr>", { remap = false })
vim.keymap.set("n", "<leader>wl", ":wincmd l<cr>", { remap = false })

-- Indent all the file
vim.keymap.set("n", "<leader>=", "<c-w>=", { remap = false })

-- Quick load of vim and lua files
vim.keymap.set("n", "<leader><leader>x", ":call alpha#save_and_exec()<cr>", { remap = false })

-- Exit insert mode from terminal buffers
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { remap = false })

-- When indenting visually does not lose the selection
vim.keymap.set("v", "<", "<gv", { remap = false })
vim.keymap.set("v", ">", ">gv", { remap = false })

-- Sort the given selection
vim.keymap.set("v", "<leader>s", ":!sort", { remap = false })

-- Allos to add break undo points
local breakers = { ",", ".", "!", "?", "$", ">", "<" }
for _, breaker in pairs(breakers) do
    vim.keymap.set("i", breaker, breaker .. "<c-g>u", { remap = false })
end

-- Do not lose the current clipboard registry when pasting over other
vim.keymap.set("v", "<leader>p", "\"_dP", { remap = false })

-- GIT
vim.keymap.set("n", "<leader>ga", ":G fetch --all -p<CR>", { remap = false })
vim.keymap.set("n", "<leader>gl", ":G pull<CR>", { remap = false })

vim.keymap.set("n", "<leader>nf", function ()
    vim.ui.input({ prompt = "New file > "}, function (file)
        if file == nil then
            return
        end
        P(file)
        vim.cmd(":e ".. vim.fn.expand("%:h") .. "/" .. file)
    end)
end, { remap = false })
