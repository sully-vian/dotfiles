---@type vim.lsp.Config
local lemminx = {
    cmd = { "lemminx" },
    filetypes = { "xml", "svg" },
    root_markers = { ".git" },
}

vim.lsp.config("lemminx", lemminx)
vim.lsp.enable("lemminx")
