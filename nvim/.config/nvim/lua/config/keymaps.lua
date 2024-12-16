-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without copy" })

vim.keymap.set("x", "<leader>p", '"_dP', { noremap = true, desc = "Paste without overwriting register" })

vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, desc = "Exit insert mode with Ctrl+c" })
