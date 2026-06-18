vim.lsp.config("biome", {
    cmd = { "biome", "lsp-proxy" },
    filetypes = { "css", "html", "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescript.tsx", "typescriptreact" },
    root_markers = { ".git", "biome.json", "package.json" },
    settings = {
        css = {
            parser = {
                tailwindDirectives = true
            }
        }
    }
})

vim.lsp.enable("biome")
