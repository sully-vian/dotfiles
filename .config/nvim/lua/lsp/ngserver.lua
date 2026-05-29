local global_node_modules = vim.fn.glob(vim.env.HOME .. "/.config/nvm/versions/node/*/lib/node_modules", true, false)

vim.lsp.config("ngserver", {
    cmd = {
        "ngserver", "--stdio",
        "--tsProbeLocations", global_node_modules,
        "--ngProbeLocations", global_node_modules
    },
    filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
    root_markers = { "angular.json" },
    settings = {}
})


vim.lsp.enable("ngserver")
