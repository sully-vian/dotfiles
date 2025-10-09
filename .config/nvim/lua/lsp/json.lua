vim.lsp.config("json", {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = { provideFormatter = true },
	root_markers = { "package.json", ".git" },
})

vim.lsp.enable("json")
