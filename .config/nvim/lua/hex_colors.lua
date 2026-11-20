-- Highlights `#rrggbb` hex color codes in every buffer with their own color as
-- background (black or white text for readability), updated as you type.

local M = {}

local hex_ns = vim.api.nvim_create_namespace("hex_colors")

-- Calculate relative luminance to ensure text remains readable over the colored background
local function get_fg_contrast(hex)
    local r = tonumber(hex:sub(2, 3), 16)
    local g = tonumber(hex:sub(4, 5), 16)
    local b = tonumber(hex:sub(6, 7), 16)
    local luminance = 0.299 * r + 0.587 * g + 0.114 * b
    return luminance > 128 and "#000000" or "#ffffff"
end

local function highlight_hex_colors(buf)
    buf = buf or vim.api.nvim_get_current_buf()

    -- Clear existing highlights in our namespace before re-evaluating
    vim.api.nvim_buf_clear_namespace(buf, hex_ns, 0, -1)

    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    for i, line in ipairs(lines) do
        local start_idx = 1
        while true do
            -- Lua pattern to match '#' strictly followed by 6 hex characters
            local s, e, hex = line:find("(#[%x][%x][%x][%x][%x][%x])", start_idx)
            if not s then break end

            local hl_group = "HexColor_" .. hex:sub(2)

            -- Generate the highlight group with the background color
            vim.api.nvim_set_hl(0, hl_group, { bg = hex, fg = get_fg_contrast(hex) })

            -- Place an extmark over the exact string coordinates
            vim.api.nvim_buf_set_extmark(buf, hex_ns, i - 1, s - 1, {
                end_col = e,
                hl_group = hl_group,
            })

            start_idx = e + 1
        end
    end
end

function M.setup()
    local group = vim.api.nvim_create_augroup("HexColors", { clear = true })
    -- Bind the function to buffer events so it updates as you type
    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
        group = group,
        callback = function(args)
            highlight_hex_colors(args.buf)
        end,
    })
end

return M
