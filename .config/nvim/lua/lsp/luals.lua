---@type vim.lsp.Config
local luals = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
}

vim.lsp.config("luals", luals)
vim.lsp.enable("luals")
