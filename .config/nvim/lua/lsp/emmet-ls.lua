vim.lsp.config("emmet-ls", {
	cmd = { "emmet-ls", "--stdio" },
	filetypes = { "css", "html" },
	root_markers = { ".git" },
})

vim.lsp.enable("emmet-ls")
