vim.lsp.config("intelephense", {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    root_markers = { "composer.json", ".git" },
    init_options = { storagePath = vim.fn.stdpath("cache") },
    settings = {
        intelephense = {
            environment = {},
            format = {
                braces = "k&r"
            }
        }
    }
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if (client and client.name == "intelephense") then
            local root_dir = client.config.root_dir
            local config_file = root_dir .. "/.intelephense.json"
            if vim.fn.filereadable(config_file) == 0 then
                return -- no config file
            end
            local file = io.open(config_file, "r")
            if not file then
                return -- failed to open
            end

            local ok, config = pcall(function()
                local foo = vim.fn.readfile(config_file)
                local content = table.concat(foo, "\n")
                return vim.json.decode(content)
            end)
            if not ok then
                vim.notify("Failed to parse .intelephense.json: " .. config, vim.log.levels.ERROR)
                return
            end
            local current_config = {}
            current_config = client.config.settings.intelephense --[[@as table]]

            client.config.settings.intelephense = vim.tbl_deep_extend(
                "force", -- override global config with local
                current_config,
                config
            )
        end
    end
})

vim.lsp.enable("intelephense")
