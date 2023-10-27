-- local u = require("lspUtilities")

vim.g.myLsps = {
  "lua_ls",
  "clangd",
  "jdtls",
}

---@class lspConfiguration see :h lspconfig-setup
---@field settings? table <string, table>
---@field root_dir? function(filename, bufnr)
---@field filetypes? string[]
---@field init_options? table <string, string|table|boolean>
---@field on_attach? function(client, bufnr)
---@field capabilities? table <string, string|table|boolean|function>
---@field cmd? string[]
---@field autostart? boolean

---@type table<string, lspConfiguration>
local serverConfigs = {}
for _, lsp in pairs(vim.g.myLsps) do
  serverConfigs[lsp] = {}
end

local function setupAllLsps()
  -- Enable snippets-completion (nvim-cmp) and folding (nvim-ufo) 
  local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
  lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
  lspCapabilities.textDocument.foldingRange = 
    { dynamicRegistration = false, lineFoldingOnly = true }

  for lsp, serverConfig in pairs(serverConfigs) do
    serverConfig.capabilities = lspCapabilities
    require("lspconfig")[lsp].setup(serverConfig)
  end
end

local function lspCurrentTokenHighlight()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local capabilities = vim.lsp.get_client_by_id(args.data.client_id).server_capabilities
      if not capabilities.documentHighlightProvider then return end

      vim.api.nvim_create_autocmd("CursorHold", {
        callback = vim.lsp.buf.document_highlight,
        buffer = args.buf,
      })
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

-- local function lspSignatureSettings()
--   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.width(vim.lsp.handlers.signature_help, {
--     border = require["lspUtilities"].borderStyle,
--   })
-- end

---------
-- LUA --
---------
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

-- return {
--   "neovim/nvim-lspconfig",
--   event = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     "hrsh7th/cmp-nvim-lsp",
--     { "antosha417/nvim-lsp-file-operations", config = true },
--   },
--
--   ------------------------
--   -- DEF PLUGIN OPTIONS --
--   ------------------------
--   config = function()
--     -- import lspconfig plugin
--     local lspconfig = require("lspconfig")
--
--     -- import cmp-nvim-lsp plugin
--     local cmp_nvim_lsp = require("cmp_nvim_lsp")
--
--     local keymap = vim.keymap -- for conciseness
--
--     local opts = { noremap = true, silent = true }
--     local on_attach = function(bufnr)
--       opts.buffer = bufnr
--
--       -----------------
--       -- DEF KEYMAPS --
--       -----------------
--       opts.desc = "Show LSP references"
--       keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
--
--       opts.desc = "Go to declaration"
--       keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
--
--       opts.desc = "Show LSP definitions"
--       keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
--
--       opts.desc = "Show LSP implementations"
--       keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
--
--       opts.desc = "Show LSP type definitions"
--       keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
--
--       opts.desc = "See available code actions"
--       keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
--
--       opts.desc = "Smart rename"
--       keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
--
--       opts.desc = "Show buffer diagnostics"
--       keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
--
--       opts.desc = "Show line diagnostics"
--       keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
--
--       opts.desc = "Go to previous diagnostic"
--       keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
--
--       opts.desc = "Go to next diagnostic"
--       keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
--
--       opts.desc = "Show documentation for what is under cursor"
--       keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
--
--       opts.desc = "Restart LSP"
--       keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
--     end
--
--     -- used to enable autocompletion (assign to every lsp server config)
--     local capabilities = cmp_nvim_lsp.default_capabilities()
--
--     -- Change the Diagnostic symbols in the sign column (gutter)
--     local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
--     for type, icon in pairs(signs) do
--       local hl = "DiagnosticSign" .. type
--       vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
--     end
--
--     lspconfig["clangd"].setup({
--       capabilities = capabilities,
--       on_attach = on_attach,
--     })
--
--     lspconfig["jdtls"].setup({
--       capabilities = capabilities,
--       on_attach = on_attach,
--     })
--
--     -- configure lua server (with special settings)
--     lspconfig["lua_ls"].setup({
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = { -- custom settings for lua
--         Lua = {
--           -- make the language server recognize "vim" global
--           diagnostics = {
--             globals = { "vim" },
--           },
--           workspace = {
--             -- make language server aware of runtime files
--             library = {
--               [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--               [vim.fn.stdpath("config") .. "/lua"] = true,
--             },
--           },
--         },
--       },
--     })
--   end,
-- }

return {
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
      -- lspSignatureSettings()
    end,
    -- config = function() require("lspconfig.ui.windows").default_options.border = u.borderStyle end,
  },
}
