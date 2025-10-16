vim.lsp.config("arduino", {
	cmd = {
		"arduino-language-server",
		"-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
		"-fqbn", "arduino:mbed:nanorp2040connect"
	},
	filetypes = { "arduino" },
	root_dir = vim.fn.getcwd(),
	capabilities = { textDocument = {} }
})

vim.lsp.enable("arduino")
