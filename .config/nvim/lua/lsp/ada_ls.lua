vim.lsp.config("ada_ls", {
    cmd = { "ada_language_server" },
    filetypes = { "ada" },
    root_markers = { "Makefile", ".git", "alire.toml", "*.gpr" },
    settings = {
        ada = {
            -- scenarioVariables = {}
        }
    }
})


vim.lsp.enable("ada_ls")
