-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }
    use('tanvirtin/monokai.nvim')

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    use('nvim-treesitter/playground') -- to see the syntax tree :TSPlaygroundToggle

    use('neovim/nvim-lspconfig')

    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    }

    use {
        'ray-x/lsp_signature.nvim',
        config = function()
            require("lsp_signature").setup({
                bind = true,
                handler_opts = {
                    boder = "rounded" },
                floating_window = true,
                hint_table = false,
                floating_window_above_cur_line = true
            })
        end
    }

    use({'glepnir/lspsaga.nvim',after = 'nvim-lspconfig',config = function() require('lspsaga').setup({}) end)
end)
