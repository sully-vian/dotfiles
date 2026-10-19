---@type vim.lsp.Config
local prisma = {
    cmd = { "prisma-language-server", "--stdio" },
    filetypes = { "prisma" },
    root_markers = { ".git", "package.json" },
    settings = {
        prisma = {
            prismaFmtBinPath = ""
        }
    }
}

vim.lsp.config("prisma", prisma)
vim.lsp.enable("prisma")
