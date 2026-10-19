---@type vim.lsp.Config
local twiggy = {
    cmd = { JS_BIN .. "twiggy-language-server", "--stdio" },
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
}

vim.lsp.config("twiggy", twiggy)
vim.lsp.enable("twiggy")
