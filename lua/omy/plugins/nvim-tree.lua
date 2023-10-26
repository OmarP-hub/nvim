return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  ------------------------
  -- DEF PLUGIN OPTIONS --
  ------------------------
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded = 1
    vim.g.loaded_netrwPlugin = 1
    
    -- change color for arrows in tree to light blue
    -- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#98971a ]])
    
    -- configure nvim-tree
    nvimtree.setup({
      view = {
        width = 35,
        -- relativenumber = true,  
      },
    	-- change folder arrow icons
    	renderer = {
        indent_markers = {
          enable = true,
        },
    		icons = {
    			glyphs = {
    				folder = {
    					arrow_closed = "", -- arrow when folder is closed
    					arrow_open = "", -- arrow when folder is open
    				},
    			},
    		},
    	},
    	-- disable window_picker for explorer 
      -- to work well with window splits
    	actions = {
        open_file = {
    			quit_on_open = true,
    			window_picker = {
    				enable = false,
    			},
    		},
    	},
      filters = {
        custom = { 
          ".DS_Store",
          ".json",
          "^.git",
        },
      },
      git = {
        ignore = true,
      },
    })

    -----------------
    -- DEF KEYMAPS --
    -----------------
    local keymap = vim.keymap -- for conciseness 

    keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
  end,
}
