---@type vim.lsp.Config
local css = {
    cmd = { JS_BIN .. "vscode-css-language-server", "--stdio" },
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
}

vim.lsp.config("css", css)
vim.lsp.enable("css")
