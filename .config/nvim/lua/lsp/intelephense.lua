---@type vim.lsp.Config
local intelephense = {
    cmd = { JS_BIN .. "intelephense", "--stdio" },
    filetypes = { "php" },
    root_markers = { "composer.json", ".git" },
    init_options = { storagePath = vim.fn.stdpath("cache") },
    settings = {
        intelephense = {
            environment = vim.empty_dict(),
            format = {
                enable = false,
                braces = "k&r"
            }
        }
    }
}

vim.lsp.config("intelephense", intelephense)
vim.lsp.enable("intelephense")
