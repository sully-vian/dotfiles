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
