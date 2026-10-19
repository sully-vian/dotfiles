-- TS types and values are in different namespaces.
-- The LSP often identifies multiple definitions (part of them in .d.ts files.
-- This local remap only shows the relevant definition

local function gotoRelevantDef()
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

---@type vim.lsp.Config
local tsc = {
    cmd = { js_bin .. "tsc", "--lsp", "--stdio" },
    init_options = { hostInfo = "neovim" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_markers = { "tsconfig.json", "package.json", ".git" },
    on_attach = function(_, bufnr)
        vim.keymap.set('n', "<leader>d", gotoRelevantDef, { buffer = bufnr, desc = "Go to relevant definition" })
    end
}

vim.lsp.config("tsc", tsc)
vim.lsp.enable("tsc")
