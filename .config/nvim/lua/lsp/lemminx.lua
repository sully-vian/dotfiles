vim.lsp.config("lemminx", {
    cmd = { "lemminx" },
    filetypes = { "xml", "svg" },
    root_markers = { ".git" },
})

vim.lsp.enable("lemminx")
