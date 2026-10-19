---@type vim.lsp.Config
local pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "pyrightconfig.json" },
    settings = {
        python = {
            analysis = {
                auaoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnoticMode = "openFilesOnly"
            }
        }
    }
}

vim.lsp.config("pyright", pyright)
vim.lsp.enable("pyright")
