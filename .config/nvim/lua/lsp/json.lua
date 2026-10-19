---@type vim.lsp.Config
local json = {
    cmd = { js_bin .. "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = { provideFormatter = true },
    root_markers = { "package.json", ".git" },
}

vim.lsp.config("json", json)
vim.lsp.enable("json")
