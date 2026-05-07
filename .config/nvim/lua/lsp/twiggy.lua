vim.lsp.config("twiggy", {
    cmd = { "twiggy-language-server", "--stdio" },
    filetypes = { "twig" },
    root_markers = { "composer.json", ".git" },
})
vim.lsp.enable("twiggy")
