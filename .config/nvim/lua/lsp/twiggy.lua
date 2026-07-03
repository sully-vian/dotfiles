vim.lsp.config("twiggy", {
    cmd = { "twiggy-language-server", "--stdio" },
    filetypes = { "twig" },
    root_markers = { "composer.json", ".git" },
    settings = {
        twiggy = {
            phpExecutable = "php",
            symfonyConsolePath = "bin/console",
            framwork = "symfony",
            diagnostics = { twigCsFixer = true }
        }
    }
})
vim.lsp.enable("twiggy")
