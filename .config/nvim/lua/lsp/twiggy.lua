vim.lsp.config("twiggy", {
    cmd = { js_bin .. "twiggy-language-server", "--stdio" },
    filetypes = { "twig" },
    root_markers = { "composer.json", ".git" },
    settings = {
        twiggy = {
            phpExecutable = "php",
            symfonyConsolePath = "bin/console",
            framework = "symfony",
            diagnostics = { twigCsFixer = true }
        }
    }
})
vim.lsp.enable("twiggy")
