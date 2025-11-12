vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "pyrightconfig.json" },
	settings = {
		python = {
			analysis = {
				auaoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnoticMode = "openFilesOnly"
			}
		}
	}
})

vim.lsp.enable("pyright")
