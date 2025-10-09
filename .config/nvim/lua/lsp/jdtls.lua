vim.lsp.config("java", {
	cmd = { "jdtls" },
	filetypes = { "java" },
	root_markers = { "gradlew", "mvnw", "pom.xml", ".git" }
})

vim.lsp.enable("java")
