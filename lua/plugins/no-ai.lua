return {
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      completion = { ghost_text = { enabled = false } },
    },
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        lua_ls = {
          settings = {
            Lua = { hint = { enable = false } },
          },
        },
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
            },
          },
        },
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                enumMemberValues = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                parameterNames = { enabled = "none" },
                parameterTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                variableTypes = { enabled = false },
              },
            },
            javascript = {
              inlayHints = {
                enumMemberValues = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                parameterNames = { enabled = "none" },
                parameterTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                variableTypes = { enabled = false },
              },
            },
          },
        },
      },
    },
  },
  { "zbirenbaum/copilot.lua", enabled = false },
  { "github/copilot.vim", enabled = false },
  { "Exafunction/codeium.nvim", enabled = false },
  { "supermaven-inc/supermaven-nvim", enabled = false },
  { "tzachar/cmp-tabnine", enabled = false },
  { "yetone/avante.nvim", enabled = false },
}
