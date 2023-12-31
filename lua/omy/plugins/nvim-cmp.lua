return {
  "hrsh7th/nvim-cmp",
  event = {
    "InsertEnter",
    "CmdLineEnter",
  },
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-cmdline", -- source for vim's commandline
    "dmitmel/cmp-cmdline-history", -- source for vim's commandline
    "hrsh7th/cmp-nvim-lsp", -- lsp input to autocompletion
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion with snippets
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },

  ------------------------
  -- DEF PLUGIN OPTIONS --
  ------------------------
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")

    local lspkind = require("lspkind")

    local function noBlankBefore()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local noBlankBef = vim.api.nvim_get_current_line():sub(1, col):match("^%s*$") == nil
      return noBlankBef
    end

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline_history", keyword_length = 2 },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" }
          }
        }
      })
    })

    cmp.setup.filetype("tex", {
      sources = {
        { name = "vimtex" },
        { name = "buffer" },
      },
    })

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      ------------------
      -- DEF MAPPINGS --
      ------------------
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<Tab>"] = cmp.mapping(function (fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif noBlankBefore() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function (fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else 
            fallback()
          end
        end, { "i", "s" }),
        }),


      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- autocompletion from lsp 
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
