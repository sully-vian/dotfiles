vim.lsp.config("tailwindcss", {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = { "css", "typescriptreact" },
	root_markers = { ".git" },
	settings = {
		tailwindCSS = {
			validate = true,
			lint = {},
			classAttributes = { "className" }
		}
	}
})

vim.lsp.enable("tailwindcss")
