---@type vim.lsp.Config
local phpantom = {
    cmd = { "phpantom_lsp" },
    filetypes = { "php" },
    root_markers = { ".phpantom.toml", "composer.json", ".git" },
}

vim.lsp.config("phpantom", phpantom)
vim.lsp.enable("phpantom")
