-- vim.opt.wrap = false       -- force """clean""" code
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
vim.opt.timeoutlen = 300 -- ms (default 1000ms)
local default_statusline =
"%<%f %h%w%m%r %=%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &busy > 0 ? '◐ ' : '' %}%{% luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status() .. '' '') or '''' ') %}%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}"
-- %<%f %h%w%m%r %=%{&showcmdloc=='statusline'? '%-10.S ' : ''}%{exists('b:keymap_name')? '<'..b:keymap_name..'> ' : ''}%{&busy>0?'◐ ':''}%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status() .. '' '') or '''' ')}%{&ruler? (&rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat) : ''}
local default_parts = {
    "%<", -- truncate left
    "%f ", --filename
    "%h", --help flag
    "%w", --preview window
    "%m", -- modified
    "%r ", -- readonly
    "%=", -- right align
    "%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}", -- showcmd
    "%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}", -- keymap
    "%{% &busy > 0 ? '◐ ' : '' %}", -- busy
    "%{% luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status() .. '' '') or '''' ') %}", -- diagnostics
    "%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}" -- ruler
}
local custom_parts = {
    "%{v:lua.get_icon()} ",
    "%y",
    " %f",
    "%m",
    "%r",
    "%=",
    "%l:%c",
    " %p%%"
}
vim.opt.statusline = table.concat(custom_parts);
vim.opt.statusline = default_statusline
vim.opt.statusline = table.concat(default_parts)
-- print(table.concat(default_parts))

-- leader
vim.g.mapleader = " "

-- mappings
local function exec_file()
    local file = vim.fn.shellescape(vim.fn.expand("%:p"))
    local output = vim.fn.system(file)
    vim.print(output)
end

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

local function lazygit()
    vim.cmd.terminal("lazygit")
    vim.cmd.startinsert()
end

local function terminal()
    vim.cmd.terminal()
    vim.cmd.startinsert()
end

vim.keymap.set('n', "<leader>q", vim.cmd.quit, { desc = "Quit" })
vim.keymap.set('n', "<leader>w", vim.cmd.write, { desc = "Save" })
vim.keymap.set('n', "<leader>f", format, { desc = "Format buffer" })
vim.keymap.set('n', "<leader>s", vim.cmd.source, { desc = "Source file" })
vim.keymap.set('n', "<Esc>", vim.cmd.noh, { desc = "Stop highlighting search results" })
vim.keymap.set('n', "<leader>t", terminal, { desc = "Open terminal" })
vim.keymap.set('t', "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- LSP
vim.keymap.set('n', "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set('n', "<leader>k", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set('n', "<leader>d", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', "<leader>R", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set('n', "<leader>c", vim.lsp.buf.code_action, { desc = "Code actions" })

-- Misc
vim.keymap.set('n', "<leader>e", exec_file, { desc = "Execute file" })
vim.keymap.set('n', "<leader>l", lazygit, { desc = "Open LazyGit" })

-- Plugins
vim.keymap.set('n', "<leader>p", "<Cmd>:Pick files<CR>", { desc = "Pick file" })
vim.keymap.set('n', "<leader>P", "<Cmd>:Pick grep_live<CR>", { desc = "Pick string" })
vim.keymap.set('n', "<leader>h", "<Cmd>:Pick help<CR>", { desc = "Help" })
vim.keymap.set('n', "<leader>o", "<Cmd>:Oil<CR>", { desc = "Open parent dir" })

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

-------------
-- Plugins --
-------------

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/wakatime/vim-wakatime" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/smjonas/live-command.nvim" },
    { src = "https://github.com/brianhuster/live-preview.nvim" },
    { src = "https://github.com/towolf/vim-helm" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" }
})

require("mini.pick").setup({
    a = true,
    options = { use_cache = true },
    window = {
        prompt_caret = "|",
        prompt_prefix = "> "
    }
})

require("lsp")

require("live-command").setup({ commands = { Norm = { cmd = "norm" } } })
vim.cmd("cnoreabbrev norm Norm")

require("oil").setup({
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _) return name == ".git" end
    }
})

require("nvim-web-devicons").setup({ variant = "dark" })

function get_icon()
    local filename = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")
    local icon, foo = require("nvim-web-devicons").get_icon(filename, extension)
    return icon or ""
end

------------------
-- Highlighting --
------------------

-- colorschemes
vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/ku1ik/vim-monokai" },
    { src = "https://github.com/LuRsT/austere.vim" },
    { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    { src = "https://github.com/projekt0n/github-nvim-theme" },
    { src = "https://github.com/nikvdp/ejs-syntax" }
})
vim.cmd("colorscheme vague")

vim.filetype.add({
    extension = { ejs = "ejs", env = "env" }
});

vim.treesitter.language.register("html", "ejs");
