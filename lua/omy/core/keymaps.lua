-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tabvim.g.mapleadaer = " "

opts.desc = "Go to tab 1"
keymap.set("n", "<leader>1", "1gt", opts);

opts.desc = "Go to tab 2"
keymap.set("n", "<leader>2", "2gt", opts);

opts.desc = "Go to tab 3"
keymap.set("n", "<leader>3", "3gt", opts);

opts.desc = "Go to tab 4"
keymap.set("n", "<leader>4", "4gt", opts);

opts.desc = "Go to tab 5"
keymap.set("n", "<leader>5", "5gt", opts);

opts.desc = "Go to tab 6"
keymap.set("n", "<leader>6", "6gt", opts);

opts.desc = "Go to tab 7"
keymap.set("n", "<leader>7", "7gt", opts);

----------------------
-- Personal Keybinds
----------------------

keymap.set("n", "<CR>", "m`o<ESC>``", { desc = "Inserts a new line under the cursor" })

keymap.set("n", "<leader>O", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
	{ desc = "Inserts new lines under the cursor with a motion" })

keymap.set("n", "<leader>o", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>",
	{ desc = "Inserts new lines above the cursor with a motion" })

opts.desc = "Go down and center screen"
keymap.set("n", "<C-d>", "<C-d>zz", opts) -- go to the end of the screen and center the screen 

opts.desc = "Go up and center screen"
keymap.set("n", "<C-u>", "<C-u>zz", opts) -- go to the start of the screen and center the screen

keymap.set("n", "0", "^", opts) -- change 0 from moving to start of the line to first non blank character in a line
