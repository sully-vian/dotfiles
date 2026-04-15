vim.lsp.config("phpactor", {
    cmd = { "phpactor", "language-server" },
    filetypes = { "php" },
    root_markers = { '.git', "composer.json", ".phpactor.yml", "phpactor.json" },
    workspace_required = true,
})
vim.lsp.enable("phpactor")
