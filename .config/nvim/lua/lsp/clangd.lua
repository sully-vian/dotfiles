vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp" },
	root_markers = { ".clangd", ".clang-format", ".git" }
})

vim.filetype.add({
	extension = {
		tpp = "cpp"
	}
})

vim.lsp.enable("clangd")
