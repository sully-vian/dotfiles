vim.lsp.config("prisma", {
	cmd = { "prisma-language-server", "--stdio" },
	filetypes = { "prisma" },
	root_markers = { ".git", "package.json" },
	settings = {
		prisma = {
			prismaFmtBinPath = ""
		}
	}
})

vim.lsp.enable("prisma")
