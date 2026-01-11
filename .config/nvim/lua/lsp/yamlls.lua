vim.lsp.config("yamlls", {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose" },
    root_markers = { "package.json", ".git" },
    settings = {
        yaml = {
            format = { enable = true },
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json"
            }
        }
    }
})

vim.lsp.enable("yamlls")
