---------------------------
----- LSP SERVER LIST -----
---------------------------
vim.g.myLsps = {
  "lua_ls",
  "clangd",
  "texlab",
  "jdtls", -- TODO: Use jdtls from nvim-jdtls to 
}          -- support lsp for entire project

---------------------------------
-- LSP CONFIGURATION FUNCTIONS --
---------------------------------

-- FIELDS AND CLASSES DESCRIPTIONS
---@class lspConfiguration see :h lspconfig-setup
---@field settings? table <string, table>
---@field root_dir? function(filename, bufnr)
---@field filetypes? string[]
---@field init_options? table <string, string|table|boolean>
---@field on_attach? function(client, bufnr)
---@field capabilities? table <string, string|table|boolean|function>
---@field cmd? string[]
---@field autostart? boolean

-- for confif lsp servers 
---@type table<string, lspConfiguration>
local serverConfigs = {}
for _, lsp in pairs(vim.g.myLsps) do
  serverConfigs[lsp] = {}
end

-- define lsp configurations
local function setupAllLsps()
  -- Enable snippets-completion (nvim-cmp) and folding (nvim-ufo) 
  local lspCapabilities = require("cmp_nvim_lsp").default_capabilities()
  lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
  lspCapabilities.textDocument.foldingRange = 
    { dynamicRegistration = false, lineFoldingOnly = true }

  local keymap = vim.keymap
  local opts = { noremap = true, silent = true }

  local on_attach = function (bufnr)
    opts.buffer = bufnr

    ----------------------------------
    ---------- DEF KEYMAPS ----------- 
    ----------------------------------
    -- lsp commands
    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts)

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

  end

  for lsp, serverConfig in pairs(serverConfigs) do
    serverConfig.capabilities = lspCapabilities
    serverConfig.on_attach = on_attach()
    require("lspconfig")[lsp].setup(serverConfig)
  end
end

local function lspCurrentTokenHighlight()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local capabilities = vim.lsp.get_client_by_id(args.data.client_id).server_capabilities
      if not capabilities.documentHighlightProvider then return end
    end,
  })
  vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
    callback = function ()
      vim.api.nvim_set_hl(0, "LspReferenceWrite", { underdashed = true }) -- definition
      vim.api.nvim_set_hl(0, "LspReferenceRead", { underdotted = true }) -- reference
      vim.api.nvim_set_hl(0, "LspReferenceText", {}) -- too mucho noise, as is underlines e.g. strings
    end,
  })
end

---------------------------------
------- LUA SERVER OPTIONS-------
---------------------------------
serverConfigs.lua_ls = {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
        keywordSnippet = "Replace",
        displayContext = 6,
        postfix = ".", -- useful for 'table.insert' and the like
      },
      diagnostics = {
        globals = { "vim" }, 
        disable = { "trailing-space" },
      },
      hint = {
        enable = true, -- enabled inlay hints
        setType = true,
        arrayIndex = "Disable",
      },
      workspace = { checkThirdParty = false },
    },
  },
}

---------------------------------
---------- LOAD LSP -------------
---------------------------------
return {
  event = { "BufReadPre", "BufNewFile" },
  {
    "folke/neodev.nvim",
    opts = {
      library = { plugins = false },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = "folke/neodev.nvim",
    init = function()
      setupAllLsps()
      lspCurrentTokenHighlight()
    end,
  },
  {
    "dnlhc/glance.nvim",
    config = function()

      ----------------------------------
      ---------- DEF KEYMAPS ----------- 
      ----------------------------------
      -- main lsp commands with glance plugin
      local keymap = vim.keymap -- for conciseness
      keymap.set("n", "<leader>gd", "<CMD>Glance definitions<CR>", {desc = "[g]lance [d]efinitions provided by lsp"})
      keymap.set("n", "<leader>gr", "<CMD>Glance references<CR>", {desc = "[g]lance [r]eferences provided by lsp"})
      keymap.set("n", "<leader>gy", "<CMD>Glance type_definitions<CR>", {desc = "[g]lance t[y]pe definitions provided by lsp"})
      keymap.set("n", "<leader>gm", "<CMD>Glance implementations<CR>", {desc = "[g]lance i[m]plementations provided by lsp"})
    end
  }
}
