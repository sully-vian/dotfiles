local dotfiles_node_modules = vim.fn.glob(vim.env.DOTFILES .. "/node_modules", true, false)

---@type vim.lsp.Config
local ngserver = {
    cmd = {
        JS_BIN .. "ngserver", "--stdio",
        "--tsProbeLocations", dotfiles_node_modules .. "/@angular/language-server/node_modules",
        "--ngProbeLocations", dotfiles_node_modules
    },
    filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
    root_markers = { "angular.json" },
    workspace_required = true,
    settings = {}
}

vim.lsp.config("ngserver", ngserver)
vim.lsp.enable("ngserver")
