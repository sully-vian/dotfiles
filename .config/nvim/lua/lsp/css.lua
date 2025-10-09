vim.lsp.config("css", {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css" },
	root_markers = { "package.json", ".git" },
	init_options = { provideFormatter = true },
	settings = {
		css = { validate = true } }
})

vim.lsp.enable("css")
