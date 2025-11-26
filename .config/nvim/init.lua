--vim.opt.wrap = false       -- force """clean""" code
vim.opt.signcolumn = "yes" -- even when no sign to show
vim.opt.cursorcolumn = false
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true -- indent as previous line but "smart" when ending a struct e.g.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false -- disable .swap file creation
vim.opt.winborder = "rounded"

-- leader
vim.g.mapleader = " "


local function format()
    local view = vim.fn.winsaveview() -- save current view

    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    local names = {}

    for _, client in ipairs(clients) do
        if client:supports_method("textDocument/formatting") then
            table.insert(names, client.name)
        end
    end
    vim.notify(table.concat(names, ","))
    vim.lsp.buf.format({
        async = false,
        callback = function(_, result, ctx)
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            vim.notify("aaa")
            if client then
                vim.notify("Formatted with " .. client.name, vim.log.levels.INFO)
            else
                vim.notify("Formatted (no client info)", vim.log.levels.INFO)
            end
        end,
        on_error = function(err)
            vim.notify("failed to format")
        end
    })
    vim.fn.winrestview(view) -- restore saved view
end

-- mappings
local function format_and_save()
    format()
    vim.cmd.write()
end

vim.keymap.set('n', "<leader>q", vim.cmd.quit, { desc = "Quit" })
vim.keymap.set('n', "<leader>w", format_and_save, { desc = "Format+Save" })
vim.keymap.set('n', "<leader>f", format, { desc = "Format buffer" })
vim.keymap.set('n', "<leader>s", vim.cmd.source, { desc = "Source file" })
vim.keymap.set('n', "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set('n', "<leader>k", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set('n', "<leader>d", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', "<leader>R", vim.lsp.buf.references, { desc = "List references" })

vim.keymap.set('n', "<leader>p", "<Cmd>:Pick files<CR>", { desc = "Pick file" })
vim.keymap.set('n', "<leader>P", "<Cmd>:Pick grep_live<CR>", { desc = "Pick string" })
vim.keymap.set('n', "<leader>h", "<Cmd>:Pick help<CR>", { desc = "Help" })

-- autocomplete
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if (client ~= nil) then
            if client:supports_method("textDocument/completion") then
                vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            end
        end
    end
})
vim.opt.completeopt:append("noselect")

-- pack
vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/loctvl842/monokai-pro.nvim" },
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/wakatime/vim-wakatime" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
})
vim.pack.update(nil, { force = true })

-- colors
vim.cmd("colorscheme vague")

require "mini.pick".setup({})

require("lsp")

require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "java", "html", "css", "javascript", "python", "vim", "typst" },
    auto_install = true,
    sync_install = false,
    ignore_install = {},
    highlight = { enable = true },
    indent = { enable = true },
    modules = {}
}
