---@type vim.lsp.Config
local ty = {
    cmd = { "ty", "server" },
    filetypes = { "python" },
    root_markers = { "ty.toml", "pyproject.toml", ".git" },
    settings = {}
}

vim.lsp.config("ty", ty)
vim.lsp.enable("ty")
