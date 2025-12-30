local home = os.getenv("HOME");

vim.lsp.config("phpactor", {
    cmd = { "phpactor", "language-server" },
    filetypes = { "php" },
    root_markers = { '.git' },
    workspace_required = true,
    init_options = {
        ["language_server_php_cs_fixer.enabled"] = true,
        ["language_server_php_cs_fixer.bin"] = home .. "/.config/composer/vendor/bin/php-cs-fixer"
    }
})
vim.lsp.enable("phpactor")
