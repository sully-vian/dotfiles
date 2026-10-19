---@type vim.lsp.Config
local eslint = {
    cmd = { JS_BIN .. "vscode-eslint-language-server", "--stdio" },
    filetypes = { "javascript", "typescript", "javascriptreact", "javascript.jsx", "typescriptreact", "typescript.tsx", "vue" },
    root_markers = { ".eslintrc.json", "tsconfig.json", "package.json", ".git" },
    settings = {
        nodePath = "",
        format = { enable = true },
        experimental = { useFlatConfig = false }
    }
}

vim.lsp.config("eslint", eslint)
vim.lsp.enable("eslint")
