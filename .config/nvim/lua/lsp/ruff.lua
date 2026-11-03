---@type vim.lsp.Config
local ruff = {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "ruff.toml", "pyproject.toml", ".git" },
    settings = {}
}

vim.lsp.config("ruff", ruff)
vim.lsp.enable("ruff")
