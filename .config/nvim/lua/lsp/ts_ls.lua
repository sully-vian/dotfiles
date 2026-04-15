local function find_root()
    local path = vim.fn.expand("%:p:h")
    local root_files = { "package.json", ".git", ".gitignore", "tsconfig.json" }

    while path ~= "/" do
        for _, f in ipairs(root_files) do
            local full = path .. "/" .. f
            if ((vim.fn.filereadable(path .. "/" .. f) == 1) or
                    (vim.fn.isdirectory(full) == 1)) then
                return path
            end
        end
        path = vim.fn.fnamemodify(path, ":h")
    end
    -- fallback to the current working directory
    return vim.loop.cwd()
end

-- TS types and values are in different namespaces.
-- The LSP often identifies multiple definitions (part of them in .d.ts files.
-- This local remap only shows the relevant definition

local function gotoRelevanDef()
    vim.lsp.buf.definition({
        on_list = function(options)
            -- Filter out definition files if multiple results
            local items = options.items
            if #items > 1 then
                items = vim.tbl_filter(function(item)
                    return not string.match(item.filename, "%.d%.ts")
                end, items)
            end
            -- Fallback to original list if filter emptied it
            if #items == 0 then items = options.items end
            vim.fn.setqflist({}, ' ', { title = options.title, items = items })
            vim.api.nvim_command("cfirst")
        end
    })
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.keymap.set('n', "<leader>d", gotoRelevanDef, { desc = "Go to relevant definition" })
    end
})

vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    init_options = { hostInfo = "neovim" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_dir = find_root(),
})

vim.lsp.enable("ts_ls")
