return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },

  ------------------------
  -- DEF PLUGIN OPTIONS --
  ------------------------
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          ".json",

          -- java files
          ".class",
          ".xml",
          ".lst",
          ".form",
        },
        path_display = { "truncate " },

        ----------------------------------
        --------- DEF MAPPINGS -----------
        ----------------------------------
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-c>"] = actions.close, -- close in insert mode
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })
    telescope.load_extension("fzf") -- load fzf native for faster parsing

    ----------------------------------
    ---------- DEF KEYMAPS ----------- 
    ----------------------------------
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy find string in current buffer" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", {desc = "List normal mode keymaps"})
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {desc = "List open buffers"})
  end,
}
