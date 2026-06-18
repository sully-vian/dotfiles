vim.lsp.config("tailwindcss", {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "css", "typescriptreact", "twig" },
    root_markers = { ".git" },
    settings = {
        tailwindCSS = {
            validate = true,
            lint = {},
            classAttributes = { "className" ,"class"}
        }
    }
})

vim.lsp.enable("tailwindcss")
