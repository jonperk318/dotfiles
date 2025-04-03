
local local_plugins = {
    {
        "harpoon",
        dir = "~/.config/nvim/lua/harpoon",
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

            vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
        end
    },
--[[
    {
        "vim-apm", dir = "~/personal/vim-apm",
        config = function()
            local apm = require("vim-apm")

            apm:setup({})
            vim.keymap.set("n", "<leader>apm", function() apm:toggle_monitor() end)
        end
    },
--]]
}

return local_plugins

