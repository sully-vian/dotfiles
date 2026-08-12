if vim.b.current_syntax then
    return
end

vim.cmd([[
    syntax match TailOperator /^==>/ contained
    syntax match TailOperator /<==$/ contained
    syntax match TailFilename /^==>\s\+.*\s\+<==$/ contains=TailOperator
]])

vim.api.nvim_set_hl(0, "TailOperator", { link = "Operator", default = true })
vim.api.nvim_set_hl(0, "TailFilename", { link = "String", default = true })

vim.b.current_syntax = "tail"
