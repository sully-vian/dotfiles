vim.diagnostic.config({
    virtual_text = false,
    signs = true,            -- show signs in the sign column
    update_in_insert = true, -- update diags in insert mode
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

local function format()
    print("Formatting...")
    vim.lsp.buf.format({ async = true })
    print("Formatted.")
end

vim.api.nvim_set_keymap("n", "<leader>e", "<cmd> lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", format, { noremap = true, silent = true })

local on_attach = function(_, bufnr)
    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = { border = "rounded" }
    }, bufnr)
end

require('lspconfig').ocamllsp.setup {
    on_attach = on_attach
}

require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                -- get langserv ro recognise the 'vim' global
                globals = { 'vim' }
            }
        }
    }
}

require('lspsaga').setup({
    ui = {
        border = 'rounded' }
})

-- "gd" pour aller à la def
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
-- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
