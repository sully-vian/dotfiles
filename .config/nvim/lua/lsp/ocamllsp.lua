local function get_ocamllsp_path()
    local handle = io.popen("dune tools which ocamllsp 2> /dev/null")
    if not handle then return "ocamllsp" end
    local result = handle:read("*a"):gsub("\n", "")
    handle:close()
    return result
end

vim.lsp.config("ocamllsp", {
    cmd = { get_ocamllsp_path() },
    filetypes = { "ocaml", "dune", "opam" },
    root_markers = { "dune-project", ".git" },
})

vim.lsp.enable("ocamllsp")
