function ColorMyPencils(color)
	-- color fallsback to default if not defined in the pywal theme
	-- color = color or "pywal"
	color = color or "monokai"
	vim.cmd.colorscheme(color)

	-- for the background to be transparent
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
