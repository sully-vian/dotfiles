---@type vim.lsp.Config
local bash = {
    cmd = { js_bin .. "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
    root_markers = { ".git" },
}

vim.lsp.config("bash", bash)
vim.lsp.enable("bash")
