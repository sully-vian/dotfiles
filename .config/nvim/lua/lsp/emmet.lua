---@type vim.lsp.Config
local emmet = {
    cmd = { js_bin .. "emmet-language-server", "--stdio" },
    filetypes = {
        "html", "htmlangular", "twig",
        "css", "scss", "sass", "less",
        "javascriptreact", "typescriptreact",
    },
    root_markers = { ".git" },
}

vim.lsp.config("emmet", emmet)
vim.lsp.enable("emmet")
