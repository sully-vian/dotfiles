vim.lsp.config("css", {
    cmd = { js_bin .. "vscode-css-language-server", "--stdio" },
    filetypes = { "css" },
    root_markers = { "package.json", ".git" },
    init_options = { provideFormatter = true },
    settings = {
        css = {
            validate = true,
            lint = {
                --unknownAtRules = "ignore"
            }
        }
    }
})

vim.lsp.enable("css")
