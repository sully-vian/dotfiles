---@type vim.lsp.Config
local arduino = {
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
    -- arduino-language-server crashes on semantic tokens: vim.NIL sends JSON null
    -- (a Lua nil would be dropped by the merge and keep the default capabilities)
    capabilities = {
        ---@diagnostic disable-next-line: assign-type-mismatch
        textDocument = { semanticTokens = vim.NIL },
        ---@diagnostic disable-next-line: assign-type-mismatch
        workspace = { semanticTokens = vim.NIL }
    }
}

vim.lsp.config("arduino", arduino)
vim.lsp.enable("arduino")
