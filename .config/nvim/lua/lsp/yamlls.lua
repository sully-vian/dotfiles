vim.lsp.config("yamlls", {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose" },
	root_markers = { "package.json", ".git" },
	settings = { yaml = { format = { enable = true } } }
})

vim.lsp.enable("yamlls")
