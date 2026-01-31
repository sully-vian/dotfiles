vim.lsp.config("lua", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".git" },
    settings = {
        Lua = {
            workspace = { -- tell the lsp that "vim" exists
                library = vim.api.nvim_get_runtime_file("", true) }
        }
    }
})

vim.lsp.enable("lua")
