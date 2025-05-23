vim.diagnostic.config({
	virtual_text = false,
	signs = true, -- show signs in the sign column
	update_in_insert = true, -- update diags in insert mode
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
        source = "always",
        header= "",
        prefix = "",
    },
})

vim.api.nvim_set_keymap("n", "<leader>e", "<cmd> lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

local on_attach = function(client, bufnr)
    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = { border = "rounded" }
    }, bufnr)
end

require('lspconfig').ocamllsp.setup{
    on_attach = on_attach
}

require('lspconfig').lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                -- get langserv ro recognise the 'vim' global
                globals = {'vim'}
            }
        }
    }
}

-- "gd" pour aller à la def
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
