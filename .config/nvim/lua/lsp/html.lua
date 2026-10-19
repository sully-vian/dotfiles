---@type vim.lsp.Config
local html = {
    cmd = { JS_BIN .. "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "svg", "twig", "htmlangular" },
    root_markers = { "package.json", ".git" },
    init_options = {
        provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { "html", "css", "javascript" }
    }
}

vim.lsp.config("html", html)
vim.lsp.enable("html")
