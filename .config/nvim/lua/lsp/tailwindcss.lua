---@type vim.lsp.Config
local tailwindcss = {
    cmd = { js_bin .. "tailwindcss-language-server", "--stdio" },
    filetypes = { "css", "typescriptreact", "twig" },
    root_markers = { ".git" },
    settings = {
        tailwindCSS = {
            validate = true,
            lint = {},
            classAttributes = { "className", "class" }
        }
    }
}

vim.lsp.config("tailwindcss", tailwindcss)
vim.lsp.enable("tailwindcss")
