local function gotoRelevantDef()
    vim.lsp.buf.definition({
        on_list = function(options)
            local items = options.items
            if #items > 1 then
                items = vim.tbl_filter(function(item) -- keep only vendor
                    return string.match(item.filename, "/vendor/")
                end, items)
            end
            if #items == 0 then items = options.items end
            vim.fn.setqflist({}, ' ', { title = options.title, items = items })
            vim.api.nvim_command("cfirst")
        end
    })
end

local phpactor_bin = vim.api.nvim_get_runtime_file("bin/phpactor", false)[1]
vim.lsp.config("phpactor", {
    --cmd = { php_bin .. "phpactor", "language-server" },
    cmd = { phpactor_bin, "language-server" },
    filetypes = { "php" },
    root_markers = { ".phpactor.json", "composer.json", ".phpactor.yml", "phpactor.json", ".git" },
    workspace_required = true,
    on_attach = function(_, bufnr)
        vim.keymap.set('n', "<leader>d", gotoRelevantDef, { buffer = bufnr, desc = "Go to relevant definition" })
    end
})

vim.lsp.enable("phpactor")
