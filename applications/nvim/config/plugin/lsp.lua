local telescope_mapper = require("alpha.telescope.mappings")

local filetype_attach = setmetatable({
    go = function(_)
        vim.cmd([[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]   )
    end,
}, {
    __index = function()
        return function() end
    end,
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local function on_attach(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>vf", function()
        return vim.lsp.buf.format({ async = true })
    end, bufopts)
    vim.keymap.set("n", "<leader>vn", vim.diagnostic.goto_next, bufopts)
    vim.keymap.set("n", "<leader>vp", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("i", "<c-h>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>vo", ":LspRestart<cr>", bufopts)

    filetype_attach[filetype](client)
end

local servers = { "rnix", "sumneko_lua", "intelephense", "gopls" }
for _, lsp in pairs(servers) do
    require("lspconfig")[lsp].setup({
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 2, prefix = "●" },
    severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- NULL ls
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
    },
})
