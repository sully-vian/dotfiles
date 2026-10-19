---@type vim.lsp.Config
local biome = {
    cmd = { js_bin .. "biome", "lsp-proxy" },
    filetypes = { "css", "html", "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescript.tsx", "typescriptreact" },
    root_markers = { "biome.json", "package.json", ".git" },
    settings = {
        css = {
            parser = {
                tailwindDirectives = true
            }
        }
    }
}

vim.lsp.config("biome", biome)
vim.lsp.enable("biome")
