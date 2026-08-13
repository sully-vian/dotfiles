vim.lsp.config("copilot", {
    cmd = { js_bin .. "copilot-language-server", "--stdio" },
    root_markers = { ".git" },
    init_options = {
        editorInfo = { name = "Neovim", version = tostring(vim.version()) },
        editorPluginInfo = { name = "Neovim", version = tostring(vim.version()) }
    },
})

---Fetches Copilot usage data asynchronously
---@param callback fun(usage: CopilotUsage|string)
local function fetch_copilot_usage(callback)
    vim.system({ "gh", "api", "copilot_internal/user" }, { text = true }, function(obj)
        if obj.code ~= 0 then
            callback("Failed to get Copilot usage: " .. obj.stderr)
            return
        end

        local ok, parsed = pcall(vim.json.decode, obj.stdout)
        if not ok then
            callback("Failed to parse Copilot usage: " .. parsed)
            return
        end

        local data = {
            completions = vim.tbl_get(parsed, "quota_snapshots", "completions"),
            chat = vim.tbl_get(parsed, "quota_snapshots", "chat"),
            reset_date = parsed.quota_reset_date,
        }

        callback(data)
    end)
end

vim.api.nvim_create_user_command("CopilotUsage", function()
    fetch_copilot_usage(function(usage)
        vim.schedule(function()
            if type(usage) == "string" then -- error
                vim.notify(usage, vim.log.levels.ERROR)
                return
            end

            vim.notify(string.format("  󰅩 %d/%d  │  󰭻 %d/%d  │  󰑐 %s",
                usage.completions.remaining, usage.completions.entitlement,
                usage.chat.remaining, usage.chat.entitlement,
                usage.reset_date))
        end)
    end)
end, { desc = "Show GitHub Copilot usage" })

vim.lsp.inline_completion.enable()
vim.keymap.set("i", "<C-Right>", vim.lsp.inline_completion.get, { desc = "Accept inline completion" })


vim.lsp.enable("copilot")
