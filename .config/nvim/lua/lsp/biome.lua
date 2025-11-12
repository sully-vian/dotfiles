vim.lsp.config("biome", {
	cmd = { "biome", "lsp-proxy" },
	filetypes = { "css", "html", "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescript.tsx", "typescriptreact" },
	root_markers = { ".git", "biome.json", "package.json" },
})

vim.lsp.enable("biome")
