---@type vim.lsp.Config
local ada = {
    cmd = { "ada_language_server" },
    filetypes = { "ada" },
    root_markers = { "Makefile", ".git", "alire.toml", "*.gpr" },
    settings = {
        ada = {
            -- scenarioVariables = {}
        }
    }
}

vim.lsp.config("ada", ada)
vim.lsp.enable("ada")
