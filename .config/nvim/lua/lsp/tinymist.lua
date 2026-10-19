---@type vim.lsp.Config
local tinymist = {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    root_markers = { ".git" },
    settings = {
        formatterMode = "typstyle"
    }
}

vim.lsp.config("tinymist", tinymist)
vim.lsp.enable("tinymist")
