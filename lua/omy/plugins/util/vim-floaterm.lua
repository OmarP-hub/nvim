return {
  "voldikss/vim-floaterm",
  event = "VeryLazy",

  ----------------------------------
  ---------- DEF KEYMAPS ----------- 
  ----------------------------------
  vim.keymap.set("n", "<leader>ftn", "<cmd>FloatermNew<CR>", { desc = "Open a floating terminal." }),
  vim.keymap.set("n", "<leader>ftx", "<cmd>FloatermKill<CR>", { desc = "Close the floating terminal." }),
  vim.keymap.set("n", "<leader>ftg", "<cmd>FloatermNew --width=0.8 --height=0.8 lazygit<CR>", { desc = "Open a floating terminal with lazygit" })
}
