---@type vim.lsp.Config
local clangd = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp" },
    root_markers = { ".clangd", ".clang-format", ".git" }
}

vim.filetype.add({
    extension = {
        tpp = "cpp"
    }
})

vim.lsp.config("clangd", clangd)
vim.lsp.enable("clangd")
