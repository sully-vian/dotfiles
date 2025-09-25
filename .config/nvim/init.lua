vim.opt.wrap = false       -- force """clean""" code
vim.opt.signcolumn = "yes" --even when no sign to show
vim.opt.cursorcolumn = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true --indent as previous line but "smart" when ending a struct e.g.
vim.opt.tabstop = 4
vim.opt.swapfile = false   -- disable .swap file creation
vim.opt.winborder = "rounded"

-- leader
vim.g.mapleader = " "

-- mappings
vim.keymap.set('n', "<leader>q", "<Cmd>:q<CR>")                -- quit all buffers
vim.keymap.set('n', "<leader>w", "<Cmd>:write<CR>")
vim.keymap.set('n', "<leader>s", "<Cmd>:write<CR>:source<CR>") -- source file
vim.keymap.set('n', "<leader>f", vim.lsp.buf.format)           -- format file
vim.keymap.set('n', "<leader>p", "<Cmd>:Pick files<CR>")
vim.keymap.set('n', "<leader>h", "<Cmd>:Pick help<CR>")

-- pack
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/loctvl842/monokai-pro.nvim" },
	{ src = "https://github.com/vague2k/vague.nvim" }
})

-- colors
vim.cmd("colorscheme vague")

require "mini.pick".setup()

require("nvim-treesitter.configs").setup {
	ensure_installed = { "lua", "java" },
	highlight = {
		enable = true,
	},
}

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".git" },
	settings = {
		Lua = {
			workspace = { -- tell the lsp that "vim" exists
				library = vim.api.nvim_get_runtime_file("", true) }
		}
	}
})

vim.lsp.config("jdtls", {
	cmd = { "jdtls" },
	filetypes = { "java" },
	root_markers = { "gradlew", "mvnw", "pom.xml", ".git" }
})
-- LSPs
vim.lsp.enable({ "lua_ls", "jdtls" })
