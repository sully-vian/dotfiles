local dotfiles_node_modules = vim.fn.glob(vim.env.DOTFILES .. "/node_modules", true, false)

vim.lsp.config("ngserver", {
    cmd = {
        js_bin .. "ngserver", "--stdio",
        "--tsProbeLocations", dotfiles_node_modules .. "/@angular/language-server/node_modules",
        "--ngProbeLocations", dotfiles_node_modules
    },
    filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
    root_markers = { "angular.json" },
    settings = {}
})


vim.lsp.enable("ngserver")
