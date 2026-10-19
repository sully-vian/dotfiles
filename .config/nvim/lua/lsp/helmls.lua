---@type vim.lsp.Config
local helmls = {
    cmd = { "helm_ls", "serve" },
    filetypes = { "helm", "yaml.helm-values" },
    root_markers = { "Chart.yaml" },
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
}

vim.lsp.config("helmls", helmls)
vim.lsp.enable("helmls")
