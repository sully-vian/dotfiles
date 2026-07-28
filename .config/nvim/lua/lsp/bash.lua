vim.lsp.config("bash", {
    cmd = { npm_bin .. "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
    root_markers = { ".git" },
})

vim.lsp.enable("bash")
