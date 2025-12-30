vim.lsp.config("arduino", {
    cmd = {
        "arduino-language-server",
        "-clangd", "/usr/bin/clangd",
        "-cli", "/usr/bin/arduino-cli",
        "-format-conf-path", "./.clang-format",
        "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
        "-fqbn", "arduino:mbed:nanorp2040connect"
    },
    filetypes = { "arduino" },
    root_dir = vim.fn.getcwd(),
    capabilities = {
        textDocument = { semanticTokens = vim.NIL },
        workspace = { semanticTokens = vim.NIL }
    }
})

vim.lsp.enable("arduino")
