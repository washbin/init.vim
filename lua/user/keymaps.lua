-- default leader is \
-- vim.g.mapleader = ','

-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
vim.keymap.set("n", "<space>w", "<Cmd>write<CR>", { desc = "Save" })

vim.keymap.set({ "n", "x" }, "cp", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "x" }, "cv", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set({ "n", "x" }, "x", '"_x', { desc = "delete without register" })
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<CR>", { desc = "Select all" })

vim.keymap.set("i", "ii", "<esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<leader>h", "<Cmd>nohlsearch<CR>", { desc = "Clear highlights" })

vim.keymap.set("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<A-k>", "<Cmd>m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", "<Cmd>m '>+1<CR>gv=gv", { desc = "Move line down" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Plugin Specifics
vim.keymap.set("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>", { desc = "NvimTree Toggle" })
vim.keymap.set("n", "<leader>r", "<Cmd>NvimTreeRefresh<CR>", { desc = "Refresh NvimTree" })
vim.keymap.set("n", "<leader>n", "<Cmd>NvimTreeFindFile<CR>", { desc = "Find File in NvimTree" })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files in Telescope" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep in Telescope" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers in Telescope" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help in Telescope" })

vim.keymap.set("n", "<leader>tg", "<Cmd>TagbarToggle<CR>", { desc = "Toggle TagBar" })
vim.keymap.set("n", "<leader>sm", "<Cmd>SymbolsOutline<CR>", { desc = "Toggle SymbolsOutline" })
