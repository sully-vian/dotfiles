vim.lsp.config("symfony", {
    cmd = { "symfony-lsp" },
    filetypes = { 'php', 'twig', 'yaml', 'json', 'xml', 'javascript', 'typescript', 'env' },
    root_markers = { "composer.json", ".git" },
    workspace_required = true,
    init_options = {
        containerProjectRoot = "/var/www/html",
        phpCommand = { "docker", "compose", "exec", "-T", "php", "php" },
        consolePath = "bin/console",
        workspaceTrust = true,
        runtimeIndexing = true
    },
    settings = {
        symfonyLsp = {
            containerProjectRoot = "/var/www/html",
        }
    }
})

vim.lsp.enable("symfony")
