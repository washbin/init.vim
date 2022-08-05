-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

local luasnip = require("luasnip")

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = "λ",
        luasnip = "⋗",
        -- buffer = "Ω",
        -- path = "🖫",
      }
      item.menu = menu_icon[entry.source.name]

      local cmp_kinds = {
        Text = "  ",
        Method = "  ",
        Function = "  ",
        Constructor = "  ",
        Field = "  ",
        Variable = "  ",
        Class = "  ",
        Interface = "  ",
        Module = "  ",
        Property = "  ",
        Unit = "  ",
        Value = "  ",
        Enum = "  ",
        Keyword = "  ",
        Snippet = "  ",
        Color = "  ",
        File = "  ",
        Reference = "  ",
        Folder = "  ",
        EnumMember = "  ",
        Constant = "  ",
        Struct = "  ",
        Event = "  ",
        Operator = "  ",
        TypeParameter = "  ",
      }
      item.kind = (cmp_kinds[item.kind] or "") .. item.kind

      return item
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
})

vim.api.nvim_exec(
  [[
    " gray
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    " blue
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
    " light blue
    highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
    highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
    highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
    " pink
    highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
    highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
    " front
    highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
    highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
    highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
  ]],
  false
)
