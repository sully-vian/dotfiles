---@type vim.lsp.Config
local ocamllsp = {
    cmd = { "dune", "tools", "exec", "ocamllsp" },
    filetypes = { "ocaml", "dune", "opam" },
    root_markers = { "dune-project", ".git" },
    settings = {
        codelens = { enable = true },
        inlayHints = { hintPatternVariables = true, hintLetBindings = true },
        extendedHover = { enable = true },
        syntaxDocumentation = { enable = true },
        merlinJumpCodeActions = { enable = true },
    }
}

vim.lsp.config("ocamllsp", ocamllsp)
vim.lsp.enable("ocamllsp")
