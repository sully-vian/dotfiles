vim.lsp.config("phpactor", {
    cmd = { "phpactor", "language-server" },
    filetypes = { "php" },
    root_markers = { ".phpactor.json", "composer.json", ".phpactor.yml", "phpactor.json", ".git" },
    workspace_required = true,
})
vim.lsp.enable("phpactor")
