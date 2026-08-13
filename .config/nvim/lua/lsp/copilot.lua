vim.lsp.config("copilot", {
    cmd = { js_bin .. "copilot-language-server", "--stdio" },
    root_markers = { ".git" },
    init_options = {
        editorInfo = { name = "Neovim", version = tostring(vim.version()) },
        editorPluginInfo = { name = "Neovim", version = tostring(vim.version()) }
    },
})

vim.lsp.enable("copilot")
