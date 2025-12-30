vim.lsp.config("ocamllsp", {
    cmd = { "ocamllsp" },
    filetypes = { "ocaml", "dune" },
    root_markers = { "package.json", ".git", "dune-project" },
})

vim.lsp.enable("ocamllsp")
