---@type vim.lsp.Config
local bash = {
    cmd = { JS_BIN .. "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
    root_markers = { ".git" },
}

vim.lsp.config("bash", bash)
vim.lsp.enable("bash")
