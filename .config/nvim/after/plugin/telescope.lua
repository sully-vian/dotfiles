local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' }) -- find all files

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("find str in proj: ") });
end)
