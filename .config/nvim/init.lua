-- vim.opt.wrap = false       -- force """clean""" code
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes" -- even when no sign to show
vim.opt.cursorcolumn = false
vim.opt.cursorline = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true -- indent as previous line but "smart" when ending a struct e.g.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false  -- disable .swap file creation
vim.opt.winborder = "rounded"
vim.opt.timeoutlen = 300  -- ms (default 1000ms)
vim.opt.updatetime = 200
vim.opt.splitright = true -- new buffer appears right
vim.opt.splitbelow = true -- new buffer appears under
vim.opt.list = true
vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '␣',
    space = '·',
    eol = '↲',
}

require('vim._core.ui2').enable({})

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

--- `vim.lsp.buf.code_action` wrapper that filters out disabled actions
local function code_action()
    vim.lsp.buf.code_action({
        filter = function(action)
            return not action.disabled
        end
    })
end

local function hover()
    return vim.lsp.buf.hover({
        max_width = math.floor(vim.o.columns * .5),
        max_height = math.floor(vim.o.lines * .5)
    })
end

-- search
---@type { items: vim.quickfix.entry[], active: boolean, idx: number, word_len:number}
local refs = { items = {}, active = false, idx = 0, word_len = 0 }
local ns = vim.api.nvim_create_namespace("LspRefSearch")
local function highlight_refs()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    if not refs.active then return end
    for _, ref in ipairs(refs.items) do
        local line = ref.lnum - 1
        local col = ref.col - 1
        local end_col = ref.end_col and (ref.end_col - 1) or (col + refs.word_len)
        pcall(vim.api.nvim_buf_add_highlight, 0, ns, "Search", line, col, end_col)
    end
end

vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = { "/" },
    callback = function()
        refs.active = false -- stop ref highlighting
        vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    end
})

vim.keymap.set('n', "<Esc>", function()
    vim.cmd.noh()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end, { desc = "Stop highlighting search results" })

vim.keymap.set('n', "?", function()
    vim.cmd.noh() -- stop search highlighting
    local current_file = vim.uri_from_fname(vim.fn.expand('%:p'))
    local cursor = vim.api.nvim_win_get_cursor(0)
    local cword = vim.fn.expand('<cword>')

    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    refs.active = false -- prevent race conditions

    vim.lsp.buf.references({ includeDeclaration = true }, {
        on_list = function(what)
            -- get only the current file references
            local items = vim.tbl_filter(function(ref)
                return vim.uri_from_fname(ref.uri or ref.filename) == current_file
            end, what.items)
            if #items == 0 then return end

            -- sort refs by line then column
            table.sort(items, function(a, b)
                if a.lnum == b.lnum then return a.col < b.col end
                return a.lnum < b.lnum
            end)

            refs.items = items
            refs.active = true
            refs.word_len = #cword

            refs.idx = 1
            for i, ref in ipairs(items) do
                if ref.lnum > cursor[1] or (ref.lnum == cursor[1] and ref.col >= cursor[2] + 1) then
                    refs.idx = i; break
                end
            end
            highlight_refs() -- apply highlights
        end
    })
end, { desc = "Navigate references" })

vim.keymap.set('n', "n", function()
    if not refs.active then
        return vim.cmd.normal({ "n", bang = true })
    end
    refs.idx = refs.idx + 1
    if refs.idx > #refs.items then refs.idx = 1 end
    local ref = refs.items[refs.idx]
    vim.api.nvim_win_set_cursor(0, { ref.lnum, ref.col - 1 })
    highlight_refs()
end)

vim.keymap.set('n', "N", function()
    if not refs.active then
        return vim.cmd.normal({ "N", bang = true })
    end
    refs.idx = refs.idx - 1
    if refs.idx < 1 then refs.idx = #refs.idx end
    local ref = refs.items[refs.idx]
    vim.api.nvim_win_set_cursor(0, { ref.lnum, ref.col - 1 })
    highlight_refs()
end)

vim.keymap.set('n', "<leader>q", vim.cmd.quit, { desc = "Quit" })
vim.keymap.set('n', "<leader>w", vim.cmd.write, { desc = "Save" })
vim.keymap.set('n', "<leader>f", format, { desc = "Format buffer" })
vim.keymap.set('n', "<leader>s", vim.cmd.source, { desc = "Source file" })
vim.keymap.set('n', "<leader>t", terminal, { desc = "Open terminal" })
vim.keymap.set('t', "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set({ 'n', 'v' }, "<leader>n", ":Norm ", { desc = "Norm" })

-- motions
vim.keymap.set({ 'n', 'v' }, 'J', '10j', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'K', '10k', { noremap = true })

-- LSP
vim.keymap.set('n', "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set('n', "<leader>k", hover, { desc = "Hover" })
vim.keymap.set('n', "<leader>d", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set('n', "<leader>R", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set('n', "<leader>c", code_action, { desc = "Code actions" })
-- Misc
vim.keymap.set('n', "<leader>e", exec_file, { desc = "Execute file" })
vim.keymap.set('n', "<leader>l", lazygit, { desc = "Open LazyGit" })

-- Plugins
vim.keymap.set('n', "<leader>i", "<Cmd>:Inspect<CR>", { desc = "Inspect with treesitter" })
vim.keymap.set('n', "<leader>I", "<Cmd>:InspectTree<CR>", { desc = "Inspect with treesitter" })
vim.keymap.set('n', "<leader>p", "<Cmd>:Pick files<CR>", { desc = "Pick file" })
vim.keymap.set('n', "<leader>P", "<Cmd>:Pick grep_live<CR>", { desc = "Pick string" })
vim.keymap.set('n', "<leader>h", "<Cmd>:Pick help<CR>", { desc = "Help" })
vim.keymap.set('n', "-", "<Cmd>:Oil<CR>", { desc = "Open parent dir" })

-- VSCode
if vim.g.vscode then
    vim.notify = require("vscode").notify
    local vscode = function(cmd)
        return function() require("vscode").call(cmd) end
    end
    vim.keymap.set('n', "<leader>q", vscode("workbench.action.closeActiveEditor"), { desc = "Quit" })
    vim.keymap.set('n', "<leader>d", vscode("editor.action.revealDefinition"), { desc = "Go to definition" })
    vim.keymap.set('n', "<leader>c", vscode("editor.action.quickFix"), { desc = "Code actions" })
    vim.keymap.set('n', "<C-W>d", vscode("editor.action.showHover"), { desc = "Show diagnostics under the cursor" })

    vim.keymap.set('n', "<leader>p", vscode("workbench.action.quickOpen"), { desc = "Pick file" })
    vim.keymap.set('n', "<leader>P", vscode("workbench.action.findInFiles"), { desc = "Pick string" })
    vim.keymap.set('n', "<leader>h", vscode("workbench.action.showCommands"), { desc = "Help" })
end

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

local function gh(addr) return "https://github.com/" .. addr end
vim.pack.add({
    { src = gh "/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = gh "/nvim-mini/mini.pick" },
    { src = gh "/folke/which-key.nvim" },
    { src = gh "/wakatime/vim-wakatime" },
    { src = gh "/chomosuke/typst-preview.nvim" },
    { src = gh "/smjonas/live-command.nvim" },
    { src = gh "/brianhuster/live-preview.nvim" },
    { src = gh "/towolf/vim-helm" },
    { src = gh "/stevearc/oil.nvim" },
    { src = gh "/m4xshen/hardtime.nvim" },
    { src = gh "/nvim-tree/nvim-web-devicons" },
    { src = gh "/hiphish/rainbow-delimiters.nvim" },
})

require("hardtime").setup({
    hints = {
        ["Vy"] = { message = function() return "Use yy or Y instead of Vy" end, length = 2 }
    },
    showmode = true,
    callback = function(text)
        text = string.gsub(text, "! ", "!\n")
        local _, win = vim.lsp.util.open_floating_preview({ text }, "plaintext",
            { close_events = { "CursorMoved", "InsertLeave" } })
        vim.wo[win].winhighlight = "Normal:ErrorMsg"
    end
})

require("mini.pick").setup({
    a = true,
    options = { use_cache = false },
    window = {
        prompt_caret = "|",
        prompt_prefix = "> "
    }
})

if not vim.g.vscode then
    require("lsp")
end

require("live-command").setup({ commands = { Norm = { cmd = "norm" } } })
vim.cmd("cnoreabbrev norm Norm")

require("oil").setup({
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _) return name == ".git" or name == ".." end
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

local nvim_treesitter = require('nvim-treesitter')
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local file_type = vim.bo.filetype
        local installed = nvim_treesitter.get_installed()
        if not vim.tbl_contains(installed, file_type) then
            --vim.notify("parser for " .. file_type .. ' isn\'t installed')
            return
        end
        pcall(vim.treesitter.start)
    end
})

-- colorschemes
vim.pack.add({
    { src = gh "/vague2k/vague.nvim" },
    { src = gh "/ku1ik/vim-monokai" },
    { src = gh "/LuRsT/austere.vim" },
    { src = gh "/blazkowolf/gruber-darker.nvim" },
    { src = gh "/projekt0n/github-nvim-theme" },
    { src = gh "/nikvdp/ejs-syntax" }
})
vim.cmd("colorscheme vague")

vim.filetype.add({
    extension = { ejs = "ejs", env = "env" }
});
